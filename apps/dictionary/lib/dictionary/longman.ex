defmodule Dictionary.Longman do
  def call(word) do
    word
    |> String.downcase()
    |> get_ids()
    |> Enum.map(&get_word_meanings/1)
  end

  defp get_ids(word, dict \\ "ldoce5") do
    url = "https://api.pearson.com/v2/dictionaries/#{dict}/entries?headword=#{word}"

    request_and_process(url, fn(body) ->
      body
      |> Map.get("results")
      |> Enum.filter(&exact_match?(&1, word))
      |> Enum.map(&Map.get(&1, "id"))
    end)
  end

  defp request_and_process(url, callback) do
    with {:ok, body} <- HttpClient.get(url)
    do
      callback.(body)
    else
      {:error, reason} ->
        raise "Oops, something went wrong: #{reason}"
    end
  end

  defp exact_match?(item, word) do
    item["headword"] == word
  end

  defp get_word_meanings(word_id) do
    url = "http://api.pearson.com/v2/dictionaries/entries/#{word_id}"

    request_and_process(url, &parse_meaning/1)
  end

  defp parse_meaning(body) do
    result = body["result"]
    senses = result["senses"]

    %{
      "word" => result["headword"],
      "part_of_speech" => result["part_of_speech"],
      "meanings" => parse_senses(senses),
    }
  end

  def parse_senses(nil), do: nil
  def parse_senses(senses) do
    senses
    |> Enum.filter(&has_definition/1)
    |> Enum.map(&parse_sense/1)
  end

  def has_definition(sense) do
    Map.has_key?(sense, "definition")
  end

  def parse_sense(sense) do
    %{}
    |> Map.put("definition", sense["definition"])
    |> put_examples(sense["examples"])
  end

  def put_examples(result, nil), do: result
  def put_examples(result, examples) do
    texts = Enum.map(examples, &Map.get(&1, "text"))
    Map.put(result, "examples", texts)
  end
end

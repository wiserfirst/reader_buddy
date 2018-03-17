defmodule HttpClient do
  @moduledoc """
  HTTP client interface
  """

  def get(url, _query \\ %{}) do
    with {:ok, response} <- HTTPoison.get(url)
    do
      handle_response(response)
    else
      {:error, error} ->
        {:error, HTTPoison.Error.message(error)}
    end
  end

  def handle_response(%HTTPoison.Response{status_code: status_code} = response)
    when status_code in 200..299 do
    safe_decode(:ok, response.body)
  end

  def handle_response(%HTTPoison.Response{status_code: _} = response) do
    safe_decode(:error, response.body)
  end

  defp safe_decode(status, body) do
    with {:ok, decoded_body} <- Poison.decode(body)
    do
      {status, decoded_body}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end

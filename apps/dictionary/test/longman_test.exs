defmodule LongmanTest do
  use ExUnit.Case

  alias Dictionary.Longman

  describe "parse results from Longman dictionary API" do
    setup do
      [
        sense_with_example: %{
          "definition" => ["used as a greeting when you see or meet someone"],
          "examples" => [
            %{"audio" => [%{"type" => "example",
              "url" => "/v2/dictionaries/assets/ldoce/exa_pron/p008-001354151.mp3"}],
              "text" => "Hello, John! How are you?"},
            %{"audio" => [%{"type" => "example",
              "url" => "/v2/dictionaries/assets/ldoce/exa_pron/p008-001725228.mp3"}],
              "text" => "Stanley, come and say hello to your nephew."},
            %{"audio" => [%{"type" => "example",
              "url" => "/v2/dictionaries/assets/ldoce/exa_pron/p008-001725232.mp3"}],
              "text" => "Well, hello there! I haven't seen you for ages."}
          ],
          "function_to_normal_box" => %{
            "explanations" => [
              %{
                "examples" => [%{"text" => "“Hi, Karen.” “Hi, Richard. How are things with you?”"}],
                "text" => "In everyday English, in informal situations, people often say hi rather than hello:"
              }
            ]
          }
        },
        sense_with_no_example: %{
          "definition" => ["used as a greeting when you see or meet someone"],
          "function_to_normal_box" => %{
            "explanations" => [
              %{
                "examples" => [%{"text" => "“Hi, Karen.” “Hi, Richard. How are things with you?”"}],
                "text" => "In everyday English, in informal situations, people often say hi rather than hello:"
              }
            ]
          }
        },
      ]
    end

    test "parse_sense with examples", context do
      expected = %{
        "definition" => ["used as a greeting when you see or meet someone"],
        "examples" => [
          "Hello, John! How are you?",
          "Stanley, come and say hello to your nephew.",
          "Well, hello there! I haven't seen you for ages.",
        ]
      }
      assert Longman.parse_sense(context[:sense_with_example]) == expected
    end

    test "parse_sense with no example", context do
      expected = %{
        "definition" => ["used as a greeting when you see or meet someone"],
      }
      assert Longman.parse_sense(context[:sense_with_no_example]) == expected
    end
  end
end

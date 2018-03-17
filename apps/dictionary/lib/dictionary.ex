defmodule Dictionary do
  @moduledoc """
  Dictionary provide interface for looking up words
  """

  alias Dictionary.Longman

  @doc """
  Interface for looking up words in dictionary
  """
  def call(word) do
    Longman.call(word)
  end
end

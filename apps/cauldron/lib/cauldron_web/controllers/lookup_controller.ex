defmodule CauldronWeb.LookupController do
  use CauldronWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"word" => word} = _params) do
    results = Dictionary.call(word)

    conn
    |> assign(:results, results)
    |> render("results.html")
  end
end

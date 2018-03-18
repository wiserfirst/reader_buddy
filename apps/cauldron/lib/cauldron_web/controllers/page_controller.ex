defmodule CauldronWeb.PageController do
  use CauldronWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

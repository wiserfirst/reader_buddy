defmodule CauldronWeb.PageControllerTest do
  use CauldronWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Reader Buddy"
  end
end

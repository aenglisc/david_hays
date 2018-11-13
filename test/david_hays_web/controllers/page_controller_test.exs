defmodule DavidHaysWeb.PageControllerTest do
  use DavidHaysWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "DavidHays"
  end
end

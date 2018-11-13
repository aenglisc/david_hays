defmodule DavidHaysWeb.PageController do
  use DavidHaysWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

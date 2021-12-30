defmodule ScdbWeb.PageController do
  use ScdbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

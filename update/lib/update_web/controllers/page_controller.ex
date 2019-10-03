defmodule UpdateWeb.PageController do
  use UpdateWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

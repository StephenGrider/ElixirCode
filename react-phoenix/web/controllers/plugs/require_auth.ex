defmodule Reddit.Plugs.RequireAuth do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn

  alias Reddit.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns.user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to do that")
      |> redirect(to: Helpers.post_path(conn, :index))
      |> halt()
    end
  end
end

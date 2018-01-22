defmodule Reddit.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Reddit.Repo
  alias Reddit.User
  alias Elixgur.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:user] ->
        conn
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end

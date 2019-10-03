defmodule Reddit.SessionControllerTest do
  use Reddit.ConnCase
  alias Reddit.SessionController
  alias Reddit.User

  @auth %{
    info: %{email: "test@test.com"},
    credentials: %{token: "123"}
  }

  def signup(conn) do
    conn
    |> bypass_through(Reddit.Router, :browser)
    |> get("/")
    |> assign(:ueberauth_auth, @auth)
    |> SessionController.callback(%{"provider" => "github"})
  end

  test "signing in creates a new account", %{conn: conn} do
    user_count = length(Repo.all(User))
    signup(conn)

    assert user_count + 1 == length(Repo.all(User))
  end

  test "signing in creates a session", %{conn: conn} do
    conn = signup(conn)
    assert get_session(conn, :user_id)
  end

  test "signing out redirects to index", %{conn: conn} do
    conn = signup(conn)
    conn = get conn, session_path(conn, :signout)

    assert redirected_to(conn) == "/"
  end

  test "oauthing twice doesnt create two accounts", %{conn: conn} do
    user_count = length(Repo.all(User))
    conn = signup(conn)
    conn = get conn, session_path(conn, :signout)
    conn
    |> recycle
    |> signup

    assert user_count + 1 == length(Repo.all(User))
  end
end

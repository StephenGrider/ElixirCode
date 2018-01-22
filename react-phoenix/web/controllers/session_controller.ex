defmodule Reddit.SessionController do
  use Reddit.Web, :controller
  plug Ueberauth

  alias Reddit.User

  def callback(%{assigns: %{ ueberauth_failure: failure }}= conn, _params) do
    IO.inspect(failure)

    conn
    |> redirect(post_path(conn, :index))
  end

  def callback(%{assigns: %{ ueberauth_auth: auth }} = conn, %{"provider" => "github"}) do
    changeset = User.changeset(%User{}, User.attrs_from_github(auth))

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: post_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> redirect(to: post_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash("Error signing in", :error)
        |> redirect(to: post_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end

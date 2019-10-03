defmodule Reddit.PostController do
  use Reddit.Web, :controller
  alias Reddit.{Post}

  plug Reddit.Plugs.RequireAuth when action in [:new, :create]
  plug :check_post_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    posts = Repo.all(Post)
    render conn, "index.html", posts: posts
  end

  def show(conn, %{"id" => post_id}) do
    post = Repo.get!(Post, post_id)
    render conn, "show.html", post: post
  end

  def new(conn, _params) do
    changeset = %Post{} |> Post.changeset(%{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"post" => post}) do
    changeset = conn.assigns.user
      |> build_assoc(:posts)
      |> Post.changeset(post)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post Created")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => post_id}) do
    post = Repo.get(Post, post_id)
    changeset = post |> Post.changeset

    render conn, "edit.html", post: post, changeset: changeset
  end

  def update(conn, %{"post" => post, "id" => post_id}) do
    changeset = Repo.get(Post, post_id) |> Post.changeset(post)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post Updated")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => post_id}) do
    Repo.get!(Post, post_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Post Deleted")
    |> redirect(to: post_path(conn, :index))
  end

  def check_post_owner(conn, _params) do
    %{params: %{"id" => post_id}} = conn

    case Repo.get(Post, post_id).user_id == conn.assigns.user.id do
      true ->
        conn
      false ->
        conn
        |> put_flash(:error, "You cannot edit that")
        |> redirect(to: post_path(conn, :index))
        |> halt()
    end
  end
end

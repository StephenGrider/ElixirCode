defmodule Reddit.PostControllerTest do
  use Reddit.ConnCase

  alias Reddit.{Post}
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = create_user
    conn = assign(conn, :user, user)

    post =
      user
      |> build_assoc(:posts)
      |> Repo.insert!

    {:ok, %{conn: conn, post: post, user: user}}
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, post_path(conn, :new)
    assert html_response(conn, 200) =~ "Create Post"
  end

  test "creates resource when data is valid", %{conn: conn} do
    post conn, post_path(conn, :create), post: @valid_attrs
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    post_count = length(Repo.all(Post))

    post conn, post_path(conn, :create), post: @invalid_attrs
    assert post_count == length(Repo.all(Post))
  end

  test "renders form for editing chosen resource", %{conn: conn, post: post} do
    conn = get conn, post_path(conn, :edit, post)
    assert html_response(conn, 200) =~ "Create Post"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, post: post} do
    put conn, post_path(conn, :update, post), post: @valid_attrs
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "redirects when a user who doesnt own a post edits it", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), post: @valid_attrs
    assert html_response(conn, 302)
  end

  test "deletes chosen resource", %{conn: conn, post: post} do
    conn = delete conn, post_path(conn, :delete, post)
    assert redirected_to(conn) == post_path(conn, :index)
    refute Repo.get(Post, post.id)
  end
end

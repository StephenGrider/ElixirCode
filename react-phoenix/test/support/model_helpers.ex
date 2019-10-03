defmodule Reddit.ModelHelpers do
  import Plug.Conn, only: [assign: 3, put_session: 3]
  alias Reddit.User
  alias Reddit.Repo

  # def login_user(conn, params \\ %{}) do
  #   {:ok, user} = create_user(params)
  #
  #   conn =
  #     conn
  #     |> put_session(:user_id, user.id)
  #     |> assign(:user, user)
  #
  #   {conn, user}
  # end

  def create_user(params \\ %{}) do
    params = Map.merge(%{
      email: "test@test.com",
      provider: "github",
      token: "12345"
    }, params)

    {:ok, user} =
      %User{}
      |> User.changeset(params)
      |> Repo.insert

    user
  end
end

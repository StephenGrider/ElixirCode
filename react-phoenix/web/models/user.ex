defmodule Reddit.User do
  use Reddit.Web, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :posts, Reddit.Post

    timestamps()
  end

  def attrs_from_github(auth) do
    %{email: auth.info.email, token: auth.credentials.token, provider: "github"}
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end

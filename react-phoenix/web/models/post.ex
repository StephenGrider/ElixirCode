defmodule Reddit.Post do
  use Reddit.Web, :model

  schema "posts" do
    field :title, :string
    belongs_to :user, Reddit.User
    has_many :comments, Reddit.Comment

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

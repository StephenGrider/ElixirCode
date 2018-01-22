defmodule Reddit.Comment do
  use Reddit.Web, :model

  schema "comments" do
    field :content, :string
    belongs_to :user, Reddit.User
    belongs_to :post, Reddit.Post

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
  end
end

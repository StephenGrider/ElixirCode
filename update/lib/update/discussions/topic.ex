defmodule Update.Discussions.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Update.Discussions.Topic


  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

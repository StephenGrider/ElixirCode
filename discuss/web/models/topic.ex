defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end
end

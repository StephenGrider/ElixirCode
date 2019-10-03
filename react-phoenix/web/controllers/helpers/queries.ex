defmodule Reddit.Queries do
  import Ecto.Query
  alias Reddit.{Topic, Post, User, Repo}

  def topics_for_posts(topic_id) do
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(:posts)
  end
end

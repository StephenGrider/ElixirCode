defmodule Reddit.CommentView do
  use Reddit.Web, :view

  def render("comments.json", %{comment: comment}) do
    %{
      id: comment.id,
      content: comment.content
    }
  end
end

defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  def join(name, _params, socket) do
    IO.puts("++++++")
    IO.puts(name)
    {:ok, %{hey: "there"}, socket}
  end

  def handle_in() do

  end
end

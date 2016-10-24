defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  def new(conn, params) do
    IO.puts "++++"
    IO.inspect conn
    IO.puts "++++"
    IO.inspect params
    IO.puts "++++"
  end
end

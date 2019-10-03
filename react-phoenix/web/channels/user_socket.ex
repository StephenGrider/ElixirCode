defmodule Reddit.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "comments:*", Reddit.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  @max_age 2 * 7 * 24 * 60 * 60

  def connect(%{"auth_token" => token}, socket) do
    token = Phoenix.Token.verify(socket, "user_socket", token)

    case token do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, _error} ->
        :error
    end
  end

  def id(_socket), do: nil
end

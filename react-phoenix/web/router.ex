defmodule Reddit.Router do
  use Reddit.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Reddit.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Reddit do
    pipe_through :browser # Use the default browser stack

    resources "/", PostController
  end

  scope "/auth", Reddit do
    pipe_through :browser

    get "/signout", SessionController, :signout
    get "/:provider", SessionController, :request
    get "/:provider/callback", SessionController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Reddit do
  #   pipe_through :api
  # end
end

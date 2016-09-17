defmodule DocraptorxSample.Router do
  use DocraptorxSample.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DocraptorxSample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/", PageController, :create
  end

  scope "/", DocraptorxSample do
    post "/callback", PageController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", DocraptorxSample do
  #   pipe_through :api
  # end
end

defmodule PhoenixDSK.Router do
  use PhoenixDSK.Web, :router

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

  scope "/", PhoenixDSK do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/users", UserController, :index
    get "/users/:userName", UserController, :show

    get "/dsks", DskController, :index

    # Keep the following around to demonstrate Phoenix hot code reloading!
    get "/hello", HelloController, :index
    # From: http://www.phoenixframework.org/docs/adding-pages
    # Notice that we put the atom :userName in the path. Phoenix will take
    # whatever value that appears in that position in the URL and pass a Map
    # with the key userName pointing to that value to the controller.
    # For example, if we point the browser at:
    # http://localhost:4000/hello/jdoe, the value of
    # :userName" will be "jdoe".
    get "/hello/:userName", HelloController, :show

  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixDSK do
  #   pipe_through :api
  # end
end

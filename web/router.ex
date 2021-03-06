defmodule Auction.Router do
  use Auction.Web, :router

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

  scope "/", Auction do
    pipe_through :browser # Use the default browser stack

    resources "/auctions", AuctionController, only: [:index, :show]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Auction do
  #   pipe_through :api
  # end
end

defmodule Auction.AuctionController do
  use Auction.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
  
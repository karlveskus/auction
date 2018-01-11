defmodule Auction.AuctionController do
  use Auction.Web, :controller
  alias Auction.{Repo,Auction}

  def index(conn, _params) do
    auctions = Repo.all(Auction)

    render conn, "index.html", auctions: auctions
  end

  def show(conn, %{"id" => id}) do
    auction = Repo.get(Auction, id)

    render conn, "show.html", auction: auction
  end
end

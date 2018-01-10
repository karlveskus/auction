defmodule Auction.AuctionTest do
  use Auction.ModelCase

  alias Auction.Auction

  @valid_attrs %{item: "some item", price: 42, status: "some status"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Auction.changeset(%Auction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Auction.changeset(%Auction{}, @invalid_attrs)
    refute changeset.valid?
  end
end

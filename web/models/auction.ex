defmodule Auction.Auction do
  use Auction.Web, :model

  schema "auctions" do
    field :item, :string
    field :price, :integer
    field :status, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:item, :price, :status])
    |> validate_required([:item, :price, :status])
  end
end

defmodule Auction.Repo.Migrations.CreateAuction do
  use Ecto.Migration

  def change do
    create table(:auctions) do
      add :item, :string
      add :price, :integer
      add :status, :string

      timestamps()
    end
  end
end

defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers
  alias Auction.{Repo,Auction}

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end
  scenario_starting_state fn _state ->
    Hound.start_session
    #Ecto.Adapters.SQL.Sandbox.checkout(Auction.Repo)
    #Ecto.Adapters.SQL.Sandbox.mode(Auction.Repo, {:shared, self()})
    %{}
  end
  scenario_finalize fn _status, _state ->
    #Ecto.Adapters.SQL.Sandbox.checkin(Auction.Repo)
    Hound.end_session
    #nil
  end

  given_ ~r/^the following auctions are open$/,
  fn state, %{table_data: table} ->

    table
    |> Enum.map(fn auction -> Auction.changeset(%Auction{"status": "open"}, auction) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)

    {:ok, state}
  end

  and_ ~r/^I want to bid "(?<price>[^"]+)" dollars for "(?<item>[^"]+)"$/,
  fn state, %{price: price,item: item} ->
    {:ok, state |> Map.put(:price, price) |> Map.put(:item, item)}
  end

  and_ ~r/^I open auctions web page$/, fn state ->
    navigate_to "/auctions"
    {:ok, state}
  end

  and_ ~r/^I click on show button next to "(?<item>[^"]+)"$/,
  fn state, %{item: item} ->
    auction = Repo.all(Auction, item: item) |> List.first()
    click({:id, "show-#{auction.id}-button"})

    {:ok, state}
  end

  and_ ~r/^I should see "(?<item>[^"]+)"$/,
  fn state, %{item: item} ->
    assert visible_in_page? item
    assert visible_in_page? "Auction details"

    {:ok, state}
  end

  and_ ~r/^I insert the bid$/, fn state ->
    fill_field({:id, "auction-bid-input"}, state[:price])

    {:ok, state}
  end

  when_ ~r/^I summit the betting request$/, fn state ->
    click({:id, "place-bid-button"})

    {:ok, state}
  end

  then_ ~r/^I should receive a confirmation message and price should be updated$/, fn state ->
    assert visible_in_page? "A new bid placed"

    {:ok, state}
  end

  then_ ~r/^I should receive a rejection message and price should not be updated$/, fn state ->
    assert visible_in_page? "Bid not placed"

    {:ok, state}
  end

end

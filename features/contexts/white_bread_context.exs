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
    %{}
  end
  scenario_finalize fn _status, _state ->
    Hound.end_session
  end

  given_ ~r/^the following auctions are open$/,
  fn state, %{table_data: table} ->

    table
    |> Enum.map(fn auction -> Auction.changeset(%Auction{"status": "open"}, auction) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)

    {:ok, state}
  end

  and_ ~r/^I want to bid "(?<argument_one>[^"]+)" dollars for "(?<argument_two>[^"]+)"$/,
  fn state, %{argument_one: _argument_one,argument_two: _argument_two} ->
    {:ok, state}
  end

  and_ ~r/^I open auctions web page$/, fn state ->
    {:ok, state}
  end

  and_ ~r/^I click on show button next to "(?<argument_one>[^"]+)"$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end

  and_ ~r/^I should see "(?<argument_one>[^"]+)"$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end

  and_ ~r/^I insert the price "(?<argument_one>[^"]+)" dollars$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end

  when_ ~r/^I summit the betting request$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a confirmation message and price should be updated$/, fn state ->
    {:ok, state}
  end

  then_ ~r/^I should receive a rejection message and price should not be updated$/, fn state ->
    {:ok, state}
  end

end

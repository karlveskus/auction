Feature: Auction bidding
  As a customer
  Such that for buying an item on auction
  I want to make a bids

  Scenario: Making bid via Auctions web page (without rejection)
    Given the following auctions are open
          | item                                    | price |
          | Chicago Bullet Speed Skate (Size 7)     | 50    |
          | Riedell Dart Derby Skates (size 8)      | 110   |
    And I want to bid "62" dollars for "Chicago Bullet Speed Skate (Size 7)"
    And I open auctions web page
    And I click on show button next to "Chicago Bullet Speed Skate (Size 7)"
    And I should see "Auction details"
    And I insert the price "60" dollars
    When I summit the betting request
    Then I should receive a confirmation message and price should be updated


  Scenario: Making bid via Auctions web page (with rejection)
    Given the following auctions are open
          | item                                    | price |
          | Chicago Bullet Speed Skate (Size 7)     | 50    |
          | Riedell Dart Derby Skates (size 8)      | 110   |
    And I want to bid "100" dollars for "Riedell Dart Derby Skates (size 8)"
    And I open auctions web page
    And I click on show button next to "Riedell Dart Derby Skates (size 8)"
    And I should see "Auction details"
    And I insert the price "100" dollars
    When I summit the betting request
    Then I should receive a rejection message and price should not be updated
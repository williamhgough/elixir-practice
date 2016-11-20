defmodule CardsTest do
  use ExUnit.Case
  doctest Cards
  
  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end
  
  test "shuffling a deck randomises it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end
  
  test "create_hand returns given size" do
    deck = Cards.create_hand(3)
    assert length(deck) == 3
  end
  
  test "create_hand returns random hand" do
    normal_deck = Cards.create_deck
    deck = Cards.create_hand(3)
    assert deck != normal_deck
  end
  
end

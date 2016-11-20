defmodule Cards do
    @moduledoc """
    Provides methods for creating and handling a deck of cards
    """
    
    @doc """
    Returns list of strings representing card deck.
    
    ## Example
        iex> Cards.create_deck
        ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
         "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
         "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
         "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
         "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]
    
    """
    def create_deck do
        values = ["Ace", "Two", "Three", "Four", "Five"]
        suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
        
        # List comprehension
        for value <- values, suit <- suits do
            "#{value} of #{suit}"
        end
    end
    
    @doc """
    Returns shuffled deck.
        
    """
    def shuffle(deck) do
        Enum.shuffle(deck)
    end
    
    @doc """
    Returns a specific card e.g "Ace of Spades".
    
    ## Example
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
    
    """
    def contains?(deck, card) do
        Enum.member?(deck, card)
    end
    
    @doc """ 
    Deals a hand of cards as in specified size.
        
    ## Example
        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
        
    """
    def deal(deck, hand_size) do
        Enum.split(deck, hand_size)
    end
    
    @doc """
    Saves a deck file to directory.
    
    ## Example
        iex> deck = Cards.create_deck
        iex> Cards.save(deck, "my_deck")
        :ok
    
    """
    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end
    
    @doc """
    Loads a local deck file by name.
    
    ## Example
        iex> Cards.load("my_deck")
        ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
        "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
        "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
        "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
        "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]
    
    """
    def load(filename) do
        case File.read(filename) do
            {:ok, binary} -> :erlang.binary_to_term binary
            {:error, _reason} -> "The file does not exist"
        end
    end
    
    @doc """
    Bootstrap function that will create a deck, shuffle it & return a hand.
    
    """
    def create_hand(hand_size) do 
        {hand, _deck} = Cards.create_deck
        |> Cards.shuffle
        |> Cards.deal(hand_size)
        hand
    end

# MODULE-END	
end

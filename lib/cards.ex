defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # #Solution-1 bad approach
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    # #Solution-2 better and short
    for suit <- suits, value <- values do  #(Note; start from inside out)
        "#{value} of #{suit}"
      end
  end

  def  shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contain?(deck, card) do
    Enum.member?(deck, card)
  end
@doc """
  Divides a deck into a hand and the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand

## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of spades"] #output


"""

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  # #works fine but still too long
  # def load(filename) do
  #   {status, binary} = File.read(filename)

  #   case status do
  #     :ok -> :erlang.binary_to_term (binary)
  #     :error -> "That file does not exist"
  #   end
  # end

  # #most efficient (pattern matching with atom and variable at same time)
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  # #combine the three methods; create_deck(), shuffle(), and deal()
 # #together by the use of pipe operator
  def create_hand(hand_size) do
    Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size) #note;output of the shuffle is the deck here
  end
end

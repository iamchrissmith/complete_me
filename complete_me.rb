require 'pry'
require_relative './lib/node'

class CompleteMe
  attr_reader :head

  def initialize
    @words = 0
    @head = Node.new("")
  end

  def count
    @words
  end

  def insert(word)
    @head.place_letters(word.split(''))
    # binding.pry
    @words += 1
  end

  def suggest(partial)
    # Send letters to head
    # Node sees if it has first letter
    # - if not, while still letters, return "No suggestions"
    # - if it does, add that letter to our results array and pass the remaining string to appropriate child
    # - if a node finds the last letter
    # -- append our results string to each childs letter
    # -- pass the new results array to each child and continue appending
    # -- until no children found
    # -- return results up the chain (may need to just assign to parent.suggestion)
  end
end

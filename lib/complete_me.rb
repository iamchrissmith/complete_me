require 'pry'
require './lib/node'

class CompleteMe
  attr_reader :head

  def initialize
    @head = Node.new("")
  end

  def count
    count_of_each = []
    current = @head
    stack = current.children.map do |key, value|
      value
    end
    until stack.empty?
      node = stack.pop
      count_of_each << node.word_end
      node.children.each_key do |key|
        stack.push(node.children[key])
      end
    end
    count_of_each.reduce(0, :+)
  end

  def find_node(letter)
    @head.find_node(letter)
  end

  def insert(word)
    @head.place_letters(word.split(''))
  end

  def populate(dictionary)
    words = dictionary.split("\n")
    words.each do |word|
      insert(word)
    end
  end

  def suggest(partial)
    letters = partial.split('')
    start_node = find_suggestion_start(letters)
    return "No Suggestions" unless start_node
    final = traverse_suggestions(partial, start_node)
    final.flatten
  end

  def traverse_suggestions (prefix, node = @head, suggestions = [])
    return prefix if node.word_end != 0

    node.children.each do |key, child|
      suggestions << traverse_suggestions(prefix + child.letter, child)
    end
    suggestions
  end

  def find_suggestion_start(letters, node = @head, suggestion = '')
    letter = letters[0]
    return false if !node.find_node(letter)
    suggestion += letters.shift
    if letters.length > 0
      find_suggestion_start(letters, node.children[letter.to_sym],suggestion)
    else
      node.children[letter.to_sym]
    end
  end
end

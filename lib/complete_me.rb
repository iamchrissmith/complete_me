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
    original = partial
    final = traverse_suggestions(partial, start_node, original, {})
    sort_suggestions(final)
  end

  def sort_suggestions(final)
    # binding.pry
    final = final.sort { |(k1, v1), (k2, v2)| [v2, k1] <=> [v1, k2] }
    final.flatten.reject { |v| !v.is_a? String}
  end

  def traverse_suggestions (prefix, node = @head, orig_prefix, suggestions)
    if node.word_end != 0 && node.children.empty?
      if !node.weight.nil? && node.weight.key?(orig_prefix)
        return {prefix => node.weight[orig_prefix]}
      else
        return {prefix => 0}
      end
    elsif node.word_end != 0
      if !node.weight.nil? && node.weight.key?(orig_prefix)
        suggestions = suggestions.merge( {prefix => node.weight[orig_prefix]} )
      else
        suggestions = suggestions.merge( {prefix => 0} )
      end
    end

    node.children.each do |key, child|
      new_prefix = prefix + child.letter
      suggestions = suggestions.merge(traverse_suggestions(new_prefix, child, orig_prefix, {}))
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

  def select(partial, word)
    letters = word.split('')
    last_node = find_suggestion_start(letters)
    if last_node.weight.nil?
      last_node.weight = {partial => 1}
    elsif last_node.weight.key?(partial)
      last_node.weight[partial] += 1
    else
      last_node.weight[partial] = 1
    end
  end
end

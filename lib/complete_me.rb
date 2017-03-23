# require 'pry'
require './lib/node'

class CompleteMe
  attr_reader :head

  def initialize
    @head = Node.new("")
  end

  def cycle_stack(stack, count)
    until stack.empty?
      node = stack.pop
      count << node.word_end
      node.children.each_key do |key|
        stack.push(node.children[key])
      end
    end
  end

  def seed_stack(current)
    current.children.map do |key, value|
      value
    end
  end

  def count
    count_of_each = []
    stack = seed_stack(@head)
    cycle_stack(stack, count_of_each)
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
    final = traverse(partial, start_node, original, {})
    sort_suggestions(final)
  end

  def sort_suggestions(final)
    final = final.sort { |(k1, v1), (k2, v2)| [v2, k1] <=> [v1, k2] }
    final.flatten.reject { |v| !v.is_a? String}
  end

  def traverse (prefix, node = @head, orig_prefix, suggestions)
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
      suggestions = suggestions.merge(traverse(new_prefix, child, orig_prefix, {}))
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

  def move_down_branch(letters, node = @head, count = 0)
    letter = letters[count]

    return false if !node.find_node(letter)

    if letter != letters.last
      count += 1
      move_down_branch(letters, node.children[letter.to_sym], count)
    else
      node.children[letter.to_sym]
    end
  end

  def prune_tree(letters, begin_delete = @head, current = @head, delete = letters[0])
    return [begin_delete, delete] if current.children.length == 0
    if current.word_end == 1 || current.children.length > 1
      begin_delete = current
      delete = letters[0]
    end
    letter = letters.shift
    current = current.find_node(letter)
    prune_tree(letters, begin_delete, current, delete)
  end

  def delete(word, last_letter = '', first_delete = true)
    letters = word.split('')
    last_node = move_down_branch(letters)
    last_node.word_end = 0
    if last_node.children.empty?
      parent, delete = prune_tree(letters)
      parent.children.delete(delete.to_sym)
    end
  end
end

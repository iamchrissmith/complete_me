require 'pry'
require './lib/node'

class CompleteMe
  attr_reader :head

  def initialize
    @head = Node.new("")
  end

  def count
    # binding.pry
    count_of_each = []
    current = @head
    stack = current.children.map do |key, value|
      # stack.push(current.children[key])
      value
    end
    until stack.empty?
      node = stack.pop
      count_of_each << node.end_of_word
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
    find_suggestion_start(letters, node = @head)
  end

  def find_suggestion_start(letters, node = @head, suggestion = '')
    letter = letters[0]
    return "No Suggestions" if !node.find_node(letter)
    suggestion += letters.shift
    # binding.pry
    if letters.length > 0
      find_suggestion_start(letters, node.children[letter.to_sym],suggestion)
    else
      # binding.pry
      # collected_suggestion = []
      collected_suggestion = collect_suggestions(node.children[letter.to_sym])
      # binding.pry
      final = []
      final << parse_collected( suggestion, collected_suggestion )
      # [suggestion.join]
    end

  end

  def parse_collected(root, collected)
    binding.pry
    collected.each do |key,value|
      root = root + key.to_s
      root = parse_collected(root, value)
    end
    root
    # until collected.empty?
    #   root = root + collected.shift.to_s
    #   if collected[0].length > 1
    #     root = parse_collected(root,collected[1])
    #   else
    #     root = root + collected[1].to_s
    #   end
    # end
    # root = collected.reduce(0) { |memo, (key, value)| memo += key.to_s }
  end

  def collect_suggestions(node, suggestion={})
    # binding.pry
    unless node.children.empty?
      node.children.each do |key, child|
        suggestion[key] = collect_suggestions(child, suggestion[key] = {})
      end
    end
    suggestion
  end

  # def find_letters(partial, suggestion = [''])
  #   letter = partial[0]
  #   # binding.pry
  #   return "No Suggestions" if !find_node(letter)
  #   suggestion << partial.shift
  #   children[letter.to_sym].find_letters(partial, suggestion)
  #   # suggestion = [suggestion[0] + letter]
  #   # binding.pry
  #   # look_down(partial, suggestion)
  # end


end

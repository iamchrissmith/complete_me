require 'pry'

class Node
  attr_reader :letter, :children
  attr_accessor :end_of_word

  def initialize(letter)
    @letter = letter
    @children = {}
    @end_of_word = 0
  end

  def find_node(letter)
    children[letter.to_sym]
  end

  def add_node(letter, is_new=0)
    new_node = Node.new(letter)
    new_node.end_of_word = is_new
    children[letter.to_sym] = new_node
  end

  def add_letters(this_letter, letters)
    last = letters.empty? ? 1 : 0
    new_node = add_node(this_letter,last)
    pass_letters(this_letter, letters)
  end

  def pass_letters(this_letter, letters)
    unless letters.empty?
      children[this_letter.to_sym].place_letters(letters)
    end
  end

  def place_letters(letters)
    this_letter = letters.shift
    if find_node(this_letter)
      pass_letters(this_letter, letters)
    else
      add_letters(this_letter, letters)
    end
  end

end

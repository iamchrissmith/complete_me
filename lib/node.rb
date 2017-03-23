require 'pry'

class Node
  attr_reader :letter, :children
  attr_accessor :weight, :word_end

  def initialize(letter)
    @letter = letter
    @children = {}
    @word_end = 0
    @weight = nil
  end

  def find_node(letter)
    children[letter.to_sym]
  end

  def add_node(letter, is_new=0)
    new_node = Node.new(letter)
    new_node.word_end = is_new
    children[letter.to_sym] = new_node
  end

  def assign_word_end(empty)
    if empty
      1
    else
      0
    end
  end

  def add_letter(this_letter, letters)
    last = assign_word_end( letters.empty? )
    new_node = add_node(this_letter,last)
  end

  def to_child(this_letter)
    children[this_letter.to_sym]
  end

  def has_child?(letter='')
    children.key?(letter.to_sym)
  end

  def word_end?
    if word_end == 1
      true
    else
      false
    end
  end

  def place_letters(letters)
    this_letter = letters.shift
    is_placed = find_node(this_letter)
    if is_placed && !letters.empty?
      child = to_child(this_letter)
      child.place_letters(letters)
    elsif is_placed
      this_node = find_node(this_letter)
      this_node.word_end = 1
    else
      child = add_letter(this_letter, letters)
      child.place_letters(letters) unless letters.empty?
    end
  end

end

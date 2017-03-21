class Node
  attr_reader :letter, :children
  def initialize(letter)
    @letter = letter
    @children = []
  end

  def find_node(letter)
    children.each.with_index do |child,idx|
      if child.letter == letter
        return idx
      end
    end
    false
  end

  def add_node(letter)
    new_node = Node.new(letter)
    children.push(new_node).index(new_node)
  end

  def add_letters(letters)
    index = add_node(letters[0])
    pass_letters(letters, index)
  end

  def pass_letters(letters, index)
    letters.shift
    unless letters.empty?
      children[index].place_letters(letters)
    end
  end

  def place_letters(letters)
    this_letter = letters[0]
    if find_node(this_letter)
      index = find_node(this_letter)
      pass_letters(letters, index)
    else
      add_letters(letters)
    end
  end
end

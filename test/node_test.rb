require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/node.rb'

class NodeTest < MiniTest::Test
  def test_node_exists
    node = Node.new("p")
    assert node
  end

  def test_node_initializes_with_empty_hash
    node = Node.new('')
    assert_equal 0, node.children.length
  end

  def test_find_node_returns_true_when_found
    node = Node.new('')
    refute node.find_node('a')
    node.add_node('a')
    assert node.find_node('a')
  end

  def test_find_node_returns_false_if_not_found
    node = Node.new('')
    assert_nil node.find_node("p")
  end

  def test_add_node_returns_new_node_with_letter
    node = Node.new('')
    result = node.add_node('a')
    assert_equal "a", result.letter
  end

  def test_add_node_adds_node_to_children
    node = Node.new('')
    result = node.add_node('a')
    assert_equal "a", node.children[:a].letter
  end

  def test_if_letter_is_last_assigns_1_to_end_of_word
    node = Node.new('')
    result = node.add_node('a',1)
    assert_equal "a", node.children[:a].letter
    assert_equal 1, node.children[:a].end_of_word
  end

  def test_if_letter_is_not_last_assigns_0_to_end_of_word
    node = Node.new('')

    result = node.add_node('a',0)
    assert_equal "a", node.children[:a].letter
    assert_equal 0, node.children[:a].end_of_word

    result1 = node.add_node('b')
    assert_equal "b", node.children[:b].letter
    assert_equal 0, node.children[:b].end_of_word
  end
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require_relative '../complete_me.rb'

class CompleteMeTest < MiniTest::Test
  def test_node_exists
    node = Node.new("p")
    assert node
  end

  def test_completeme_exists
    completion = CompleteMe.new
    assert completion
  end

  def test_completeme_word_count_starts_0
    completion = CompleteMe.new
    assert_equal 0, completion.count
  end

  def test_completeme_word_count_increments_with_insert
    completion = CompleteMe.new
    assert_equal 0, completion.count
    completion.insert("pizza")
    assert_equal 1, completion.count
    completion.insert("pizzeria")
  end

  def test_completeme_word_insert_adds_nodes
    completion = CompleteMe.new
    completion.insert("pizza")
    refute_nil completion.head.find_node("p")
  end

  def test_find_node_returns_false_if_not_found
    completion = CompleteMe.new
    completion.head.add_letters(["p"])
    refute_nil completion.head.find_node("p")
  end
  def test_suggest_returns_array_of_options
    completion = CompleteMe.new
    completion.insert("pizza")
    result = completion.suggest("piz")
    assert_equal ["pizza"], result
    completion.insert("pizzeria")
    result = completion.suggest("piz")
    assert_equal ["pizza", "pizzeria"], result
  end
end

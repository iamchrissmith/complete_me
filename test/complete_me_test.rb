require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/complete_me.rb'

class CompleteMeTest < MiniTest::Test
  def test_completeme_exists
    completion = CompleteMe.new
    assert completion
  end

  def test_completeme_starts_without_word_count
    completion = CompleteMe.new
    assert_equal 0, completion.count
  end

  def test_find_node_returns_true_when_found
    completion = CompleteMe.new
    refute completion.find_node('a')
    completion.insert('a')
    assert completion.find_node('a')
  end

  def test_find_node_returns_false_if_not_found
    completion = Node.new('')
    assert_nil completion.find_node("p")
  end

  def test_completeme_word_count_increments_with_insert
    completion = CompleteMe.new
    completion.insert("pizza")
    assert_equal 1, completion.count
    completion.insert("pizzeria")
    assert_equal 2, completion.count
  end

  def test_completeme_word_insert_adds_nodes
    completion = CompleteMe.new
    completion.insert("pizza")
    refute_nil completion.find_node("p")
  end

  def test_find_letters_returns_no_suggestions_if_not_found
    skip
    completion = CompleteMe.new

    result = completion.suggest("a")
    expected = "No Suggestions"

    assert_equal expected, result

    added = completion.insert('a')
    assert_equal "a", completion.head.children[:a].letter
    result_2 = completion.suggest("ab")
    assert_equal expected, result_2
  end

  def test_find_letters_returns_array_of_found_letters
    skip
    completion = CompleteMe.new
    completion.insert('a')
    assert_equal "a", completion.head.children[:a].letter

    completion.head.children[:a].add_node('a')
    assert_equal "a", completion.head.children[:a].children[:a].letter

    completion.head.children[:a].children[:a].add_node('a')
    assert_equal "a", completion.head.children[:a].children[:a].children[:a].letter

    result = completion.suggest("aaa")
    expected = ["aaaa"]
    assert_equal expected, result
  end

  def test_suggest_returns_array_of_options_one_word
    skip
    completion = CompleteMe.new
    completion.insert("pizza")
    result = completion.suggest("piz")
    assert_equal ["pizza"], result
  end

  def test_suggest_returns_array_of_options_more_than_one_word
    skip
    completion = CompleteMe.new
    completion.insert("pizza")
    completion.insert("pizzeria")
    result = completion.suggest("piz")
    assert_equal ["pizza", "pizzeria"], result
  end

  def test_add_suggestion_letter_returns_with_letter_appended
    skip
    node = Node.new('')
    result = node.add_suggestion_letter("a", ["aaa", "bbb", "ccc"])
    expected = ["aaaa", "bbba", "ccca"]
    assert_equal expected, result
  end

  def test_branch_suggestions_creates_array_for_children
    skip
    node = Node.new('')
    result = node.add_suggestion_letter("aaa", ["", "", ""])
    expected = ["aaa", "aaa", "aaa"]
    assert_equal expected, result
  end

  def test_populate_suggestions_returns_suggestion_if_no_children
    skip
    node = Node.new('')
    result
  end

  def test_populate_adds_whole_dictionary
    # skip
    completion = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    # dictionary = file.read
    completion.populate(dictionary)
    assert_equal 235886, completion.count
    # puts completion.count
  end

end

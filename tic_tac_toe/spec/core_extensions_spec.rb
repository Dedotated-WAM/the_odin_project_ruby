require_relative "spec_helper"
require "minitest/autorun"

class TestArray < MiniTest::Test
  def test_all_empty_returns_true_if_all_elements_of_array_are_empty
    assert_equal ["", "", ""].all_empty?, true
  end

  def test_all_empty_returns_false_if_some_elements_of_array_are_not_empty
    assert_equal ["", "1", ""].all_empty?, false
  end

  def test_all_empty_returns_true_for_an_empty_array
    assert_equal [].all_empty?, true
  end

  def test_all_same_returns_true_if_all_array_elements_are_identical
    assert_equal %w[1 1 1].all_same?, true
  end

  def test_all_same_returns_false_if_all_array_elements_are_not_identical
    assert_equal %w[1 2 1].all_same?, false
  end

  def test_all_same_returns_true_for_an_empty_array
    assert_equal [].all_same?, true
  end

  def test_any_empty_returns_true_for_empty_element
    assert_equal ["1", "", "2"].any_empty?, true
  end

  def test_any_empty_returns_false_for_full_array
    assert_equal %w[1 2 3].any_empty?, false
  end

  def test_any_empty_returns_true_for_empty_array
    assert_equal [].any_empty?, true
  end

  def test_none_empty_returns_true_for_full_array
    assert_equal %w[1 2 3].none_empty?, true
  end

  def test_none_empty_returns_false_for_empty_element
    assert_equal ["1", "", "3"].none_empty?, false
  end

  def test_none_empty_returns_false_for_empty_array
    assert_equal [].none_empty?, false
  end
end

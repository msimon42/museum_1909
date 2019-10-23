require 'minitest'
require 'minitest/autorun'
require_relative '../lib/patron'

class PatronTest < Minitest::Test
  def setup
    @bob = Patron.new('Bob', 20)
  end

  def test_existence
    assert_instance_of Patron, @bob
  end

  def test_name
    assert_equal 'Bob', @bob.name
  end

  def test_cash
    assert_equal 20, @bob.spending_money
  end

  def test_interests
    assert_equal [], @bob.interests
  end

  def test_add_interest
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal ['Dead Sea Scrolls', 'Gems and Minerals'], @bob.interests
  end   
end

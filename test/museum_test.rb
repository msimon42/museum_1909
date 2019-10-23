require 'minitest'
require 'minitest/autorun'
require_relative '../lib/museum'
require_relative '../lib/exhibit'
require_relative '../lib/patron'

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new('Bob', 20)
    @sally = Patron.new('Sally', 20)
    @tj = Patron.new("TJ", 7)
    @morgan = Patron.new("Morgan", 15)
  end

  def test_existence
    assert_instance_of Museum, @dmns
  end

  def test_name
    assert_equal 'Denver Museum of Nature and Science', @dmns.name
  end

  def test_exhibits
    assert_equal [], @dmns.exhibits
  end

  def test_patrons
    assert_equal [], @dmns.patrons
  end

  def test_add_patrons
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_add_exhibit
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_exhibit_recommendation
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("IMAX")

    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_patrons_by_interest
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")

    interest_list = {
          @gems_and_minerals => [@bob],
          @dead_sea_scrolls => [@bob, @sally],
          @imax => []
    }

    assert_equal interest_list, @dmns.patrons_by_exhibit_interest
  end

  def test_patrons_of_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @dmns.generate_exhibits

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @sally.add_interest("Dead Sea Scrolls")
    @tj.add_interest("IMAX")
    @tj.add_interest("Dead Sea Scrolls")
    @morgan.add_interest("Gems and Minerals")
    @morgan.add_interest("Dead Sea Scrolls")

    @dmns.admit(@bob)
    @dmns.admit(@sally)
    @dmns.admit(@tj)
    @dmns.admit(@morgan)

    patrons_of_exhibits = {
      @gems_and_minerals => [@bob, @morgan],
      @dead_sea_scrolls => [@bob, @sally],
      @imax => []
    }

    assert_equal patrons_of_exhibits, @dmns.patrons_of_exhibits
  end

end

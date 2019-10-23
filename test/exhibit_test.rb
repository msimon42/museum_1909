require 'minitest'
require 'minitest/autorun'
require_relative '../lib/exhibit'

class ExhibitTest < Minitest::Test
  def setup
    @exhibit1 = Exhibit.new('Mummies', 10)
  end

  def test_existence
    assert_instance_of Exhibit, @exhibit1
  end

  def test_name
    assert_equal 'Mummies', @exhibit1.name
  end

  def test_cost
    assert_equal 10, @exhibit1.cost
  end     

end

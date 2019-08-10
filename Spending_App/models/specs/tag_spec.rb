require('minitest/autorun')
require('minitest/rg')

require_relative('../tag.rb')

class TestTag < MiniTest::Test

  def setup()
    @tag = Tag.new(
      {
        'type' =>'Gym',
        'budget_id' => 5
      }
    )
  end

  def test_get_type()
    assert_equal('Gym', @tag.type())
  end

  def test_get_budget_id()
    assert_equal(5, @tag.budget_id())
  end

end

require('minitest/autorun')
require('minitest/rg')

require_relative('../tag.rb')

class TestTag < MiniTest::Test

  def setup()
    @tag = Tag.new(
      {
        'type' =>'Gym'
      }
    )
  end

  def test_get_type()
    assert_equal('Gym', @tag.type())
  end

end

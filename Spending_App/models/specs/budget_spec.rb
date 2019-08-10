require('minitest/autorun')
require('minitest/rg')

require_relative('../budget.rb')

class TestBudget< MiniTest::Test


  def setup()
    @budget = Budget.new(
      {
        'budget' => 500
      }
    )

  end

  def test_get_budget()
    assert_equal(500, @budget.budget())
  end

end

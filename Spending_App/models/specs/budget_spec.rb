require('minitest/autorun')
require('minitest/rg')

require_relative('../budget.rb')

class TestBudget< MiniTest::Test


  def setup()
    @budget1 = Budget.new(
      {
        'budget' => 500
      }
    )

    @budget2 = Budget.new(
      {
        'budget' => 29
      }
    )
    @budget3 = Budget.new(
      {
        'budget' => -200
      }
    )
    @budget4 = Budget.new(
      {
        'budget' => 0
      }
    )


  end

  def test_get_budget()
    assert_equal(500, @budget1.budget())
  end

  def test_budget_low()
    assert_equal("Only £#{@budget2.budget} left!", @budget2.alert())
  end

  def test_budget_reached()
    assert_equal('Budget reached!', @budget4.alert())
  end

  def test_over_budget()
    assert_equal('Over budget!', @budget3.alert())
  end



end

require('minitest/autorun')
require('minitest/rg')

require_relative('../transaction.rb')

class TestTransaction < MiniTest::Test

  def setup()

    @transaction = Transaction.new(
      {
        'tag_id' => 5,
        'merchant_id' => 7,
        'tr_date' => '09/08',
        'amount' => 10.50    
      }
    )

  end

  def test_get_tag_id()
    assert_equal(5, @transaction.tag_id())
  end

  def test_get_merchant_id()
    assert_equal(7, @transaction.merchant_id())
  end

  def test_get_amount()
    assert_equal(10.50, @transaction.amount())
  end

  def test_get_tr_date()
    assert_equal('09/08', @transaction.tr_date())
  end





end

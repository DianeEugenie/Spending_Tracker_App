require('minitest/autorun')
require('minitest/rg')

require_relative('../merchant.rb')

class TestMerchant < MiniTest::Test

  def setup()
    @merchant = Merchant.new(
      {
        'name' => 'TESCO'
      }
    )
  end

  def test_get_name()
    assert_equal('TESCO', @merchant.name())
  end

end

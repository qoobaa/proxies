require "helper"

module One
  def one; 1 end
end

module Two
  def two; 2 end
end

module Three
  def three; 3 end
end

class TestProxyExtend < Test::Unit::TestCase
  test "extend works properly with array" do
    proxy = Proxy.new("target", :extend => [One, Two, Three])
    assert_equal 1, proxy.one
    assert_equal 2, proxy.two
    assert_equal 3, proxy.three
  end

  test "extend works with single value" do
    proxy = Proxy.new("target", :extend => Two)
    assert_equal 2, proxy.two
  end
end

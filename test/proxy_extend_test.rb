require "test_helper"

module One
  def one; 1 end
end

module Two
  def two; 2 end
end

module Three
  def three; 3 end
end

class TestProxyExtend < Minitest::Test
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  def test_extend_works_properly_with_array
    proxy = Proxy.new(lambda { @object.target_method }, :extend => [One, Two, Three])
    assert_equal 1, proxy.one
    assert_equal 2, proxy.two
    assert_equal 3, proxy.three
  end

  def test_extend_works_with_single_value
    proxy = Proxy.new(lambda { @object.target_method }, :extend => Two)
    assert_equal 2, proxy.two
  end
end

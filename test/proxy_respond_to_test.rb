require "test_helper"

class TestProxyRespondTo < Minitest::Test
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  def test_proxy_respond_to_returns_true_on_existing_method
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert proxy.proxy_respond_to?(:proxy_owner)
  end

  def test_proxy_respond_to_returns_false_on_non_existing_method
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    refute proxy.proxy_respond_to?(:non_existing_method)
  end
end

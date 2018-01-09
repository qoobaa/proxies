require "test_helper"

class TestProxyOwner < Minitest::Test
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  def test_proxy_owner_is_defined
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_equal @object, proxy.proxy_owner
  end

  def test_proxy_responds_to_proxy_owner
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert proxy.proxy_respond_to?(:proxy_owner)
  end

  def test_proxy_does_not_respond_to_non_existing_method
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    refute proxy.proxy_respond_to?(:non_existing_method)
  end
end

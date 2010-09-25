require "helper"

class TestProxyOwner < Proxies::TestCase
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  test "proxy_owner is defined" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_equal @object, proxy.proxy_owner
  end

  test "proxy responds to proxy_owner" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert proxy.proxy_respond_to?(:proxy_owner)
  end

  test "proxy does not respond to non_existing_method" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_false proxy.proxy_respond_to?(:non_existing_method)
  end
end

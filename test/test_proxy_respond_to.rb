require "helper"

class TestProxyRespondTo < Proxies::TestCase
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  test "proxy_respond_to? returns true on existing method" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert proxy.proxy_respond_to?(:proxy_owner)
  end

  test "proxy_respond_to? returns false on non-existing method" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_false proxy.proxy_respond_to?(:non_existing_method)
  end
end

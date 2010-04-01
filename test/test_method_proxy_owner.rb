require "helper"

class TestMethodProxyOwner < Test::Unit::TestCase
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).at_most_once.returns(@target)
  end

  test "proxy_owner is defined" do
    proxy = MethodProxy.new(@object, :target_method)

    assert_equal @object, proxy.proxy_owner
  end
end

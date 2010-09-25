require "helper"

class TestProxyTarget < Proxies::TestCase
  def setup
    @target = "target"
    @object = mock
  end

  test "non-existing proxy method call is passed to the target" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.length, proxy.length
  end

  test "proxy method returns correct result" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method }) do
      def length_plus_one
        proxy_target.length + 1
      end
    end
    assert_equal @target.length + 1, proxy.length_plus_one
  end

  test "object_id method call is passed to proxy target" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.object_id, proxy.object_id
  end

  test "send method call is passed to proxy target" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.send(:length), proxy.send(:length)
  end

  test "== method is passed to proxy_target" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert @target == proxy
    assert proxy == @target
  end

  test "equal? method is passed to proxy_target" do
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert proxy.equal?(@target)
  end

  test "target method is not called if not needed" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_equal @object, proxy.proxy_owner
  end

  test "lazy target is called once even if false returned" do
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    @object.expects(:target_method).once.returns(false)
    assert_equal "false", proxy.to_s
    assert_equal "false", proxy.to_s
  end
end

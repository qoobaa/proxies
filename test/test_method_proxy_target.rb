require "helper"

class TestMethodProxyTarget < Test::Unit::TestCase
  def setup
    @target = "target"
    @object = mock
  end

  test "non-existing proxy method call is passed to the target" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method)
    assert_equal @target.length, @proxy.length
  end

  test "proxy method returns correct result" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method) do
      def length_plus_one
        proxy_target.length + 1
      end
    end
    assert_equal @target.length + 1, @proxy.length_plus_one
  end

  test "object_id method call is passed to proxy target" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method)
    assert_equal @target.object_id, @proxy.object_id
  end

  test "send method call is passed to proxy target" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method)
    assert_equal @target.send(:length), @proxy.send(:length)
  end

  test "== method is passed to proxy_target" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method)
    assert @target == @proxy
    assert @proxy == @target
  end

  test "equal? method is passed to proxy_target" do
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method)
    assert @proxy.equal?(@target)
  end

  test "target_method is not called if not needed" do
    @proxy = MethodProxy.new(@object, :target_method)
    assert_equal @object, @proxy.proxy_owner
  end
end

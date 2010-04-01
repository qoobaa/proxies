require "helper"

class TestMethodProxyTarget < Test::Unit::TestCase
  def setup
    @target = "target"
    @object = mock
    @object.expects(:target_method).once.returns(@target)
    @proxy = MethodProxy.new(@object, :target_method) do
      def length_plus_one
        proxy_target.length + 1
      end
    end
  end

  test "non-existing proxy method call is passed to the target" do
    assert_equal @target.length, @proxy.length
  end

  test "proxy method returns correct result" do
    assert_equal @target.length + 1, @proxy.length_plus_one
  end

  test "object_id method call is passed to proxy target" do
    assert_equal @target.object_id, @proxy.object_id
  end

  test "send method call is passed to proxy target" do
    assert_equal @target.send(:length), @proxy.send(:length)
  end

  test "== method is passed to proxy_target" do
    assert @target == @proxy
    assert @proxy == @target
  end

  test "equal? method is passed to proxy_target" do
    assert @proxy.equal?(@target)
  end
end

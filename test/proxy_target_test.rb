require "test_helper"

class TestProxyTarget < Minitest::Test
  def setup
    @target = "target"
    @object = mock
  end

  def test_non_existing_proxy_method_call_is_passed_to_the_target
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.length, proxy.length
  end

  def test_proxy_method_returns_correct_result
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method }) do
      def length_plus_one
        proxy_target.length + 1
      end
    end
    assert_equal @target.length + 1, proxy.length_plus_one
  end

  def test_object_id_method_call_is_passed_to_proxy_target
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.object_id, proxy.object_id
  end

  def test_send_method_call_is_passed_to_proxy_target
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert_equal @target.send(:length), proxy.send(:length)
  end

  def test_equal_equal_method_is_passed_to_proxy_target
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert @target == proxy
    assert proxy == @target
  end

  def test_equal_method_is_passed_to_proxy_target
    @object.expects(:target_method).once.returns(@target)
    proxy = Proxy.new(lambda { @object.target_method })
    assert proxy.equal?(@target)
  end

  def test_target_method_is_not_called_if_not_needed
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    assert_equal @object, proxy.proxy_owner
  end

  def test_lazy_target_is_called_once_even_if_false_returned
    proxy = Proxy.new(lambda { @object.target_method }, :owner => @object)
    @object.expects(:target_method).once.returns(false)
    assert_equal "false", proxy.to_s
    assert_equal "false", proxy.to_s
  end
end

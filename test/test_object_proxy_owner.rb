require "helper"

class TestObjectProxyOwner < Test::Unit::TestCase
  test "proxy_owner is defined if owner given" do
    owner = "owner"

    proxy = ObjectProxy.new("target", :owner => owner) do
      def owner_length_plus_one
        proxy_owner.length + 1
      end
    end

    assert owner.length + 1, proxy.owner_length_plus_one
  end

  test "proxy_owner is not defined if owner not given" do
    proxy = ObjectProxy.new("target") do
      def owner_length_plus_one
        proxy_owner.length + 1
      end
    end

    assert_raises(NoMethodError) { proxy.owner_length_plus_one }
  end

  test "proxy_owner can be nil value" do
    proxy = ObjectProxy.new("target", :owner => nil) do
      def owner_nil?
        proxy_owner.nil?
      end
    end

    assert proxy.owner_nil?
  end
end

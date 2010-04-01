require "helper"

class TestTrueProxyOwner < Test::Unit::TestCase
  test "@owner is defined if owner given" do
    owner = "owner"

    proxy = TrueProxy.new("target", :owner => owner) do
      def owner_length_plus_one
        @owner.length + 1
      end
    end

    assert owner.length + 1, proxy.owner_length_plus_one
  end

  test "@owner is not defined if owner not given" do
    proxy = TrueProxy.new("target") do
      def owner_length_plus_one
        @owner.length + 1
      end
    end

    assert_raises(NoMethodError) { proxy.owner_length_plus_one }
  end

  test "@owner can be nil value" do
    proxy = TrueProxy.new("target", :owner => nil) do
      def owner_nil?
        @owner.nil?
      end
    end

    assert proxy.owner_nil?
  end
end

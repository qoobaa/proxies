module Proxies
  module ProxyOwner
    def proxy_owner; @owner end
  end

  module ProxyRespondTo
    def proxy_respond_to?(method)
      this = self
      !!::Kernel.eval("defined?(this.#{method})")
    end
  end

  class Proxy < defined?(BasicObject) ? BasicObject : Object
    instance_methods.each { |m| undef_method(m) if m.to_s !~ /^__/ }

    # Creates a new proxy for target. You can pass a block (anonymous
    # module) to extend the proxy object "inline".
    #
    # ==== Options
    # * <tt>:owner</tt> - Optional owner object
    # * <tt>:extend</tt> - Module or array of modules used to extend
    # *   the newly created proxy object
    #
    # ==== Examples
    #   Proxy.new(lambda { [1, 2, 3] }) do
    #     def extension_method
    #       proxy_target.length * 500
    #     end
    #   end
    #
    #   Proxy.new(lambda { my_method }, :extend => MyExtension) do
    #     def add_owner_and_target_values
    #       proxy_target.value + proxy_owner.value
    #     end
    #   end
    #
    #   Proxy.new(lambda { my_method }, :owner => self) do
    #     def do_something
    #       ...
    #     end
    #   end
    #
    #   Proxy.new(lambda { something }, :extend => [FirstExtension, SecondExtension])

    def initialize(lazy_target, options = {}, &block)
      @lazy_target = lazy_target
      @owner = options[:owner] if options.key?(:owner)

      extends = ::Kernel.Array(options[:extend])
      extends << ::Module.new(&block)
      extends << ::Proxies::ProxyOwner if defined?(@owner)
      extends << ::Proxies::ProxyRespondTo
      extends.each { |m| m.send(:extend_object, self) }
    end

    def proxy_target
      defined?(@target) ? @target : @target = @lazy_target.call
    end

    def method_missing(name, *args, &block)
      proxy_target.send(name, *args, &block)
    end
  end
end

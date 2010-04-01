module Proxies
  class MethodProxy < defined?(BasicObject) ? BasicObject : Object
    instance_methods.each { |m| undef_method(m) if m.to_s !~ /^__/ }

    # Creates a new proxy for target method of given object. You can
    # pass a block (anonymous module) to extend the proxy object
    # "inline".
    #
    # ==== Options
    # * <tt>:extend</tt> - Module or array of modules used to extend
    # *   the newly created proxy object
    #
    # ==== Examples
    #   MethodProxy.new(self, :my_method) do
    #     def extension_method
    #       proxy_target.length * 500
    #     end
    #   end
    #
    #   MethodProxy.new(self, :my_method, :extend => MyExtension) do
    #     def add_owner_and_target_values
    #       proxy_target.value + proxy_owner.value
    #     end
    #   end
    #
    #   MethodProxy.new(self, :other_method, :extend => [FirstExtension, SecondExtension])

    def initialize(owner, method_name, options = {}, &block)
      @owner = owner
      @method_name = method_name

      extends = Array(options[:extend])
      extends << ::Module.new(&block)
      extends.each { |m| m.send(:extend_object, self) }
    end

    def proxy_target
      @target = @owner.send(@method_name) unless defined?(@target)
      @target
    end

    def proxy_owner
      @owner
    end

    def method_missing(name, *args, &block)
      proxy_target.send(name, *args, &block)
    end
  end
end

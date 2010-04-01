module Proxies
  class ObjectProxy < defined?(BasicObject) ? BasicObject : Object
    instance_methods.each { |m| undef_method(m) if m.to_s !~ /^__/ }

    # Creates a new proxy for target object. You can pass a block
    # (anonymous module) to extend the proxy object "inline".
    #
    # ==== Options
    # * <tt>:owner</tt> - Optional owner object
    # * <tt>:extend</tt> - Module or array of modules used to extend
    # *   the newly created proxy object
    #
    # ==== Examples
    #   ObjectProxy.new(target_object) do
    #     def extension_method
    #       @target.length * 500
    #     end
    #   end
    #
    #   ObjectProxy.new(target_object, :owner => self, :extend => MyExtension) do
    #     def add_owner_and_target_values
    #       @target.value + @owner.value
    #     end
    #   end
    #
    #   ObjectProxy.new(target_object, :extend => [FirstExtension, SecondExtension])

    def initialize(target, options = {}, &block)
      @target = target
      @owner = options[:owner] if options.key?(:owner)

      extends = Array(options[:extend])
      extends << ::Module.new(&block)
      extends.each { |m| m.send(:extend_object, self) }
    end

    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end

module ProxyOwner
  def proxy_owner; @proxy_owner end
end

class Proxy < defined?(BasicObject) ? BasicObject : Object
  instance_methods.each { |m| undef_method(m) if m.to_s !~ /^__/ }

  def initialize(target, options = {}, &block)
    @proxy_target = target
    @proxy_owner = options[:owner] if options.key?(:owner)

    extends = Array(options[:extend])
    extends << ::Module.new(&block)
    extends << ::ProxyOwner if defined?(@proxy_owner)
    extends.each { |m| m.send(:extend_object, self) }
  end

  def proxy_target
    @proxy_target
  end

  def method_missing(name, *args, &block)
    @proxy_target.send(name, *args, &block)
  end
end

class ResourceFactory < BasicObject

  attr_accessor :attributes

  def initialize
    @attributes = {}
  end

  def build class_name, attributes
    puts "calling ResourceFactory.build"
    c = ::Object.const_get(class_name.to_s).new()
    attributes.each do |k, v|
      if c.respond_to? k.to_s.downcase
        c.send(k.to_s.downcase+"=", v)
      elsif c.respond_to? k.to_s.downcase+"="
        c.send(k.to_s.downcase, v)
      else
        puts "Error: Method not found "+ k.to_s
      end
    end
    return c
  end

  def method_missing(name, *args, &block)
    @attributes[name] = args[0]
  end
end


class ResourceFactoryProxy
  def method_missing(m, *args, &block)
    if block_given?
      puts "DEBUG:  ResourceFactoryProxy.method_missing called #{m} with #{args.inspect} and #{block}"
      factory = ResourceFactory.new
      factory.instance_eval(&block)
      b = factory.build(m, factory.attributes )
      b.name = args.first.to_s if b.respond_to? :name
      Resources.registry[args[0]] = b
    else
      puts "DEBUG:  ResourceFactoryProxy.method_missing called #{m} with #{args.inspect} and no block"
    end
  end
end

class Resources

  @@registry = {}
  @@obj_cache = []

  def initialize(&block)
    puts "INFO: Create #{self.class.to_s} Instance"
    factory = ResourceFactoryProxy.new
    factory.instance_eval(&block)
  end

  def self.add(&block)
    Resources.new(&block)
  end

  def self.registry
    @@registry
  end
end
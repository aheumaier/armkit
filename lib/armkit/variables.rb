require "json"

class Variables
  @@count = 0
  @@instances = []
  attr_reader :name, :value

  # TODO: stupid Bug. Since instance_eval treats varOne as a function
  # all values are Arrays - unless you call Varibale.new
  # A catcher is needed to handle poperly
  def initialize(name, value)
    @name = name
    @value = value.first 
    @@count += 1
    @@instances << self
  end

  def self.add(&block)
    instance_eval(&block)
  end

  def self.registry
    @@instances
  end

  def self.count
    @@count
  end

  def to_ref(name)
    "[variable('#{name}')]"
  end

  def to_hash
    { @name => @value }
  end

  def self.render_json
    JSON.pretty_generate(@@instances.map(&:to_hash).inject(&:merge))
  end

  def self.get_var(var)
    Variables.registry[var.to_s.to_sym]
  end

  def self.method_missing(m, *args, &block)
    if block_given?
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and #{block}"
    else
      var = Variables.new(m, args)
    end
  end
end

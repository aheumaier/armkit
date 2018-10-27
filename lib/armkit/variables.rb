require "json"

class Variables
  @@count = 0
  @@instances = []
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
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

  def to_json
    { @name => @value.first }
  end

  def self.render_json
    JSON.pretty_generate(@@instances.map(&:to_json).inject(&:merge))
  end

  def self.getVar(var)
    Variables.registry[var.to_s.to_sym]
  end

  def self.method_missing(m, *args, &block)
    if block_given?
      puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect} and #{block}"
    else
      # puts "DEBUG:  Variables.method_missing called #{m} with #{args.inspect}"
      var = Variables.new(m, args)
    end
  end
end

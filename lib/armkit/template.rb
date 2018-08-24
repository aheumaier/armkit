class Template < TemplateBase

  def initialize
    super
    @schema = "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
    @contentVersion = "1.0.0.0"
    @parameters = Hash.new { |hash, key| hash[key] = {} }
    @variables = Hash.new { |hash, key| hash[key] = {} }
    @resources = Array.new { [] }
    @outputs = Hash.new { |hash, key| hash[key] = {} }
  end

  def self.add(&block)
    Template.new(&block)
  end

  def self.parse(&block)
    Template.new(&block).dump
  end

  def to_json
    @variables = Variables.to_json

    Resources.registry.each do |k, v|
      logger "Resource registry; " + v.inspect
      v.to_template
      @resources << $out_hash
    end
    hash = { "$schema"         => @schema,
             "contentVersion"  => @contentVersion,
             "variables"       => @variables,
             "parameters"      => @parameters,
             "resources"       => @resources,
             "outputs"         => @outputs
    }
    JSON.pretty_generate(hash)
  end

  def dump
    to_json
  end

  def Object.const_missing(name)
    if item = AzureResources.obj_cache.select { |c| c.inspect =~ /::#{name}$/ }
      puts "DEBUG:  Object.const_missing Class #{name} not found: but #{item.first} exists in obj_cache"
      item.first
    else
      raise "const_missing: Class #{name} not found"
    end
  end
end

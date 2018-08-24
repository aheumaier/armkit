class TemplateBase
  include Armkit

  def initialize(&block)
    logger "Create #{self.class.to_s} Instance"
    @registry = {}
    @obj_cache = []
    instance_eval(&block)
  end

  def self.add(&block)
    TemplateBase.new(&block)
  end

  def logger message, level='info'
    if $DEBUG
      puts level.upcase+': '+message.to_s
    end
  end
end
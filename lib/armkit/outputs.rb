class Outputs < TemplateBase

  def self.add(&block)
    Outputs.new(&block)
  end
end
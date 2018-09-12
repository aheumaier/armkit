class Parameters < TemplateBase

  def self.add(&block)
    Parameters.new(&block)
  end
end
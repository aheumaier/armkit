require "test_helper"

class ArmkitTest < Minitest::Test

  def setup
    @template_parse = Template.parse do
      Resources.add do
      end
      Outputs.new do
      end
    end
    @template_add = Template.add do
      Resources.add do
      end
      Outputs.new do
      end
    end
  end

  def test_that_template_add_returns_template_class
    assert @template_add.instance_of?(Template)
  end

  def test_that_template_parse_returns_json
    assert valid_json?(@template_parse)
  end

  def test_that_template_has_initialized_contentVersion_instance_var
    assert @template_add.instance_variable_defined?(:@contentVersion)
    assert @template_add.instance_variable_get(:@contentVersion).instance_of?(String)
  end

  def test_that_template_has_initialized_parameters_instance_var
    assert @template_add.instance_variable_defined?(:@parameters)
    assert @template_add.instance_variable_get(:@parameters).instance_of?(Hash)
  end

  def test_that_template_has_initialized_variables_instance_var
    assert @template_add.instance_variable_defined?(:@variables)
    assert @template_add.instance_variable_get(:@variables).instance_of?(Hash)
  end

  def test_that_template_has_initialized_resources_instance_var
    assert @template_add.instance_variable_defined?(:@resources)
    assert @template_add.instance_variable_get(:@resources).instance_of?(Array)
  end

end

require "test_helper"

class TemplateTest < Minitest::Test

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
    @is_json_expected = '{
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "variables": {
        },
        "parameters": {
        },
        "resources": [

        ],
        "outputs": {
        }
    }'
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

  def test_that_template_has_initialized_resources_instance_var
    assert @template_add.instance_variable_defined?(:@outputs)
    assert @template_add.instance_variable_get(:@outputs).instance_of?(Hash)
  end

  def test_that_template_responds_to_json
    assert @template_add.respond_to?('to_json')
  end

  def test_that_template_renders_valid_json_structure
    assert compare_json(@template_add.to_json, @is_json_expected)
  end

  # def test_that_unknown_constants_are_found_from_azure_objects
  #   Template.add do
  #     Resources.add do
  #       vnet = VirtualNetwork do
  #         test "test"
  #       end
  #     end
  #   end
  #   assert vnet.instance_of?('Azure::Network::Mgmt::V2017_09_01::Models::VirtualNetwork')
  # end
end


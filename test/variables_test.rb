require "test_helper"

class VariablesTest < Minitest::Test

  def setup
    @variables_add_simple = Variables.add do
      varOne "two"
      varTwo "two"
    end

    @variables_add_complex = Variables.add do
      varOne "two"
      varTwo "two"
      environmentSettings do
        myTest do
          instanceSize "Small"
          instanceCount "1"
        end
        prod do
          instanceSize "Large"
          instanceCount "4"
        end
      end
      varThree 466732
    end

    @is_json_expected_simple = '{
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "variables": {
          "varOne": "two",
          "varTwo": "two"
        },
        "parameters": {
        },
        "resources": [

        ],
        "outputs": {
        }
    }'

    @is_json_expected_complex = '{
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "variables": {
          "varOne": "two",
          "varTwo": "two",
          "environmentSettings": {
            "test": {
              "instanceSize": "Small",
              "instanceCount": 1
            },
            "prod": {
              "instanceSize": "Large",
              "instanceCount": 4
            },
            "varThree": "466732"
          }
        },
        "parameters": {
        },
        "resources": [

        ],
        "outputs": {
        }
    }'
  end

  def test_that_variables_add_returns_variables_class
    assert @template_add.instance_of?(Template)
  end

  def test_that_variables_add_returns_json
    assert valid_json?(@variables_add_simple)
  end

  def test_that_variables_responds_to_json
    assert @variables_add_simple.respond_to?('to_json')
  end

  def test_that_variables_renders_valid_simple_json_structure
    assert compare_json(@variables_add_simple.to_json, @is_json_expected_simple)
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


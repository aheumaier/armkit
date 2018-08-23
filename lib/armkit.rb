require "azure_mgmt_compute"
require "azure_mgmt_network"
require 'ms_rest_azure'

require_relative "armkit/version"
require_relative "armkit/template_base"
require_relative "armkit/resource_factory"
require_relative "armkit/template"
require_relative "armkit/resources"
require_relative "armkit/parameters"
require_relative "armkit/variables"
require_relative "armkit/outputs"
require_relative "armkit/azure_resources"

require 'pp'
require 'json'

module Armkit

  def self.getVar var
    Variables.registry[ var.to_s.to_sym ]
  end
end

class String
  def underscore
    self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
  end
end

$out_hash = {"properties" => {}}
$DEBUG = false


class Object
  def to_template parent = nil
    resourceMapper = self.class.mapper
    resourceMapperKeys = resourceMapper[:type][:model_properties].keys

    self.instance_variables.each do |resourceAttribute|
      strippedResAttrSymbl = resourceAttribute.to_s.delete('@').to_sym

      next unless resourceMapperKeys.include?(strippedResAttrSymbl) # skip if resourceMapperKeys not include the strippedResAttrSymbl

      resourceHashKey = resourceMapper[:type][:model_properties][strippedResAttrSymbl][:serialized_name].to_s
      resourceHashValue = self.public_send(strippedResAttrSymbl) if self.respond_to? strippedResAttrSymbl

      unless resourceHashValue.is_a?(String) || resourceHashValue.is_a?(TrueClass) || resourceHashValue.is_a?(Array)
        resourceHashValue.to_template  resourceHashKey
      else
        # TODO this next lines really have to be refactored
        if parent.nil?
          $out_hash[resourceHashKey] = resourceHashValue
        else
          puts "Parent: " + parent.to_s if $DEBUG
          parent = parent.split('.')
          if parent.length == 1
            $out_hash[parent] = {}
            $out_hash[parent][resourceHashKey] = resourceHashValue
          else
            $out_hash[parent.first][parent.last] = {}
            $out_hash[parent.first][parent.last][resourceHashKey] = resourceHashValue
          end
        end
        parent = nil
      end
    end # end each.instance_variables
  end

end # end of class


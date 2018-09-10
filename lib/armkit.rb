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
  $out_hash = { "properties" => {} }
  $DEBUG = false
end

# TODO This seems ununsed code  - wait for full test coverage
# class String
#   def underscore
#     self.gsub(/::/, '/').
#         gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
#         gsub(/([a-z\d])([A-Z])/,'\1_\2').
#         tr("-", "_").
#         downcase
#   end
# end

class Hash
  def insert_at(nested_hash,path_array,kvPair)
    puts ""
    puts "Calling Hash.insert_at(#{nested_hash}, #{path_array}, #{kvPair})"
    puts "Start at #{ path_array}"
    path_array.each do |level|
      puts level
      if path_array.length >= 1
        puts" Lenghth ist 1"
        nested_hash[level].merge(kvPair)
        puts nested_hash.inspect
        return nested_hash
      else
        a = path_array[1..path_array.length]
        puts a.inspect
        insert_at(nested_hash[level], a, kvPair)
      end
    end
  end
end

# TODO this next lines really have to be refactored. Maybe this is obsolet when moving serialization logic to core classes
#
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

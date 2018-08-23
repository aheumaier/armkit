#!/usr/bin/env ruby
require_relative "../lib/armkit"
Template.parse do
  
  Variables.add do
    varOne "two"
    varTwo "two"
    environmentSettings do
        myTest do
          instanceSize "Small"
          instanceCount 1
        end
        prod do
            instanceSize "Large"
            instanceCount 4
        end
    end
    vatThree 466732
  end
  
  Parameters.add do
  end

  Resources.add do

    VirtualNetwork "myNewtwork" do
      address_space  ['10.0.0.0/16']
      subnets [ "mySubnetA" ]
    end

    # VirtualMachine "VM-MultiNic" do
    #   hardwareProfile 'defaultHwProfile'
    #   storageProfile "storage_profile"
    #   osProfile "os_profile"
    #   networkProfile "network_profile"
    #   type "Microsoft.Compute/virtualMachines"
    #   tags { "a => b"}
    # end

  end

  Outputs.new do
  end

end




[![Build Status](https://travis-ci.org/aheumaier/armkit.svg?branch=development)](https://travis-ci.org/aheumaier/armkit)
[![Maintainability](https://api.codeclimate.com/v1/badges/dbd2e0cd6179173de415/maintainability)](https://codeclimate.com/github/aheumaier/armkit/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/dbd2e0cd6179173de415/test_coverage)](https://codeclimate.com/github/aheumaier/armkit/test_coverage)

# Armkit

Welcome to the armkit gem! Armkit is an infrastructure modeling framework that allows you to define your cloud resources using an imperative programming interface.

The Armkit is basically a wrapper around [ARM Templating](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates), which abstracts ARM template definitions of Azure resources into an object-oriented library. This allows developers to define higher-level abstractions of resources, which can easily be reused. It also allows for deeper integration into application code and more dynamic generation of resources. The Azure Armkit can then be used to render the higher-level definitions into templates. A developer can also choose to generate a diff of resources to create or update and directly deploy resource definitions to the cloud(not implmented yet). Armkit will even take care of generating additional template resources to supply the necessary deployment infrastructure (e.g.: a storgae bucket to hold zipped Azure functions).

Cloud infrastructure templates often contain repeated stanzas, information which must be loaded from external sources, and other functionality that would be easier handled as code, instead of configuration.

Consider when a userdata script needs to be added to a Cloud infrastructure template. Traditionally, you would re-write the script by hand in a valid JSON format. Using the DSL, you can specify the file containing the script and generate the correct information at runtime.

:UserData => base64(interpolate(file('userdata.sh')))

Additionally, Cloud infrastructure templates are just massive JSON documents, making general readability and reusability an issue. The DSL allows not only a cleaner format (and comments!), but will also allow the same DSL template to be reused as needed.

## Installation

**This requires Ruby 2.4 upwards**

Add this line to your application's Gemfile:

```ruby
gem 'armkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install armkit

## Usage

Get started with a simple example

```ruby
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
    varThree 466732
  end

  Parameters.add do
  end

  Resources.add do

    VirtualNetwork "myNewtwork" do
      address_space  ['10.0.0.0/16']
      subnets [ "mySubnetA" ]
    end

    VirtualMachine "VM-MultiNic" do
      hardwareProfile 'defaultHwProfile'
      storageProfile "storage_profile"
      osProfile "os_profile"
      networkProfile "network_profile"
      type "Microsoft.Compute/virtualMachines"
    end

  end

  Outputs.new do
  end

end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

```bash
@ git clone https://github.com/aheumaier/armkit.git
$ cd ./armkit
$ ruby examples/simple_starting_example.dsl
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aheumaier/armkit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Armkit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/armkit/blob/master/CODE_OF_CONDUCT.md).

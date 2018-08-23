[![Build Status](https://travis-ci.org/aheumaier/armkit.svg?branch=master)](https://travis-ci.org/aheumaier/armkit)

# Armkit

Welcome to the armkit gem!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'armkit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install armkit

## Usage

Get started with a simpel example

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
      tags { "a => b"}
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

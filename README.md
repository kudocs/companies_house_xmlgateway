# CompaniesHouseXmlgateway

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/companies_house_xmlgateway`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'companies_house_xmlgateway'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install companies_house_xmlgateway

## Usage

CompaniesHouseXmlgateway.config.test_mode = true
CompaniesHouseXmlgateway.config.password = "F6D8BSRT88P"
CompaniesHouseXmlgateway.config.presenter_id = "66663060000"

result = CompaniesHouseXmlgateway.client.perform_confirmation_statement({ number: '10234624', type: 'EW', name: 'KUDOCS TESTING LIMITED', auth_code: 'ABC123', contact_name: 'Ben Dunham', contact_number: '07919388025' }, {})

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kudocs/companies_house_xmlgateway.
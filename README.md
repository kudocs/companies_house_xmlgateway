# CompaniesHouseXmlgateway

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

```ruby
CompaniesHouseXmlgateway.config.test_mode = true
CompaniesHouseXmlgateway.config.password = "F6D8BSRT88P"
CompaniesHouseXmlgateway.config.presenter_id = "66663060000"

result = CompaniesHouseXmlgateway.client.perform_confirmation_statement({ 
  number: '10234624',
  type: 'EW',
  name: 'KUDOCS TESTING LIMITED',
  auth_code: 'ABC123',
  contact_name: 'Ben Dunham',
  contact_number: '01234567890'
}, {})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
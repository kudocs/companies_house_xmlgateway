require 'singleton'

module CompaniesHouseXmlgateway
  class Config
    include Singleton
    attr_accessor :test_mode, :presenter_id, :password
  end
end
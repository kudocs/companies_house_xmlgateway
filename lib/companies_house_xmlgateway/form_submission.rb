require 'securerandom'

module CompaniesHouseXmlgateway
  class FormSubmission
    attr_reader :id, :company, :data
    attr_accessor :xml
    
    def initialize(company, data)
      @company = company
      @data = data
      
      # Generate a truly unique identifier for this submission
      @id = SecureRandom.hex(3)
    end
  end
end
module CompaniesHouseXmlgateway
  module Service
    class DirectorResignation < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'OfficerResignation'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/...'
      
      # Generate the XML document that is embedded in the envelope for a Director Resignation action
      def build(submission)
        super do |xml|
          xml.ConfirmationStatement(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            
          end
        end
      end
    end
  end
end
  
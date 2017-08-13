module CompaniesHouseXmlgateway
  module Service
    class ConfirmationStatement < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ConfirmationStatement'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/ConfirmationStatement-v1-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for Confirmation Statement submission
      def build(submission)
        super do |xml|
          xml.ConfirmationStatement(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.ReviewDate Date.today.to_s
            xml.StateConfirmation 'true'
          end
        end
      end
    end
  end
end
  
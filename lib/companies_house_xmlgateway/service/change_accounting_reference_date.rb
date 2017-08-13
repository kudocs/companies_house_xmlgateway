module CompaniesHouseXmlgateway
  module Service
    class ChangeAccountingReferenceDate < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ChangeAccountingReferenceDate'
      SCHEMA_XSD = ''
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build
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
  
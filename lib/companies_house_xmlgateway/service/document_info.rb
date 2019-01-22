module CompaniesHouseXmlgateway
  module Service
    class DocumentInfo < CompaniesHouseXmlgateway::Service::BaseName
      API_CLASS_NAME = 'DocumentInfo'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/CompanyDocument.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Director Appointment action
      def build(submission)
        super do |xml|
          xml.DocumentInfoRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/v1-0',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "#{SCHEMA_XSD}"
          ) do
             xml.CompanyNumber submission.data[:company_number]
             xml.CompanyName submission.data[:company_name] 
             xml.ImageKey submission.data[:img_key]
          end
        end
      end
    end
  end
end
  
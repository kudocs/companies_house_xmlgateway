module CompaniesHouseXmlgateway
  module Service
    class DocumentRequest < CompaniesHouseXmlgateway::Service::BaseName
      API_CLASS_NAME = 'DocumentRequest'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/CompanyDocument.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Director Appointment action
      def build(submission)
        super do |xml|
          xml.DocumentRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/v1-0',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "#{SCHEMA_XSD}"
          ) do
             xml.UserReference submission.data[:user_ref]
             xml.DocRequestKey submission.data[:doc_key]              
          end
        end
      end
    end
  end
end
  
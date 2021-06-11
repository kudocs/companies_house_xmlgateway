module CompaniesHouseXmlgateway
  module Service
    class GetDocument < CompaniesHouseXmlgateway::Service::Base
      API_CLASS_NAME = 'GetDocument'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/GetDocument-v1-1.xsd'
      
      # Generate the XML for a request for submission statuses of outstanding submissions
      def build(submission)
        super do |xml|
          xml.GetDocument(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.DocRequestKey submission.company[:doc_key]
          end
        end
      end
    end
  end
end
  
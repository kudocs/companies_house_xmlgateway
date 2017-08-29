module CompaniesHouseXmlgateway
  module Service
    class AcknowledgeSubmissionStatus < CompaniesHouseXmlgateway::Service::Base
      API_CLASS_NAME = 'StatusAck'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/GetStatusAck-v1-1.xsd'
      
      # Generate the XML for a request for submission statuses of outstanding submissions
      def build(submission)
        super do |xml|
          xml.StatusAck(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          )
        end
      end
    end
  end
end
  
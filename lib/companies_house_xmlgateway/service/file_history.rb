module CompaniesHouseXmlgateway
  module Service
    class FileHistory < CompaniesHouseXmlgateway::Service::BaseName
      API_CLASS_NAME = 'FilingHistory'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/FilingHistory-v2-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Director Appointment action
      def build(submission)
        super do |xml|
          xml.FilingHistoryRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/v1-0',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "#{SCHEMA_XSD}"
          ) do
             xml.CompanyNumber submission.data[:company_number]
             xml.CapitalDocInd 0    
          end
        end
      end
    end
  end
end
  
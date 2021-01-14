module CompaniesHouseXmlgateway
  module Service
    class PscStatementNotification < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'PSCStatementNotification'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/PSCStatementNotification-v1-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.PSCStatementNotification(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
           xml.CompanyStatement submission.data[:statement] if submission.data[:statement_type] == 'company' 
           xml.PSCStatement submission.data[:statement] if submission.data[:statement_type] == 'psc' 
           xml.RegisterEntryDate Time.now.strftime("%Y-%m-%d")
          end
        end
      end
    end
  end
end
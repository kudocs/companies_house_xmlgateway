module CompaniesHouseXmlgateway
  module Service
    class NameSearch < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'NameSearch'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/NameSearch.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Director Appointment action
      def build(submission)
        super do |xml|
          xml.NameSearchRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/v1-0',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk/v1-0 #{SCHEMA_XSD}"
          ) do
            #xml.OfficerAppointment do
              xml.CompanyName submission.data[:name]
              xml.DataSet 'LIVE'
              xml.SameAs 0
              xml.SearchRows 20
          end
        end
      end
    end
  end
end
  
module CompaniesHouseXmlgateway
  module Service
    class PscCessation < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'PSCCessation'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/PSCCessation-v1-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Secretary Appointment action
      def build(submission)
        super do |xml|
          xml.PSCCessation(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            
            xml.Individual do
              xml.Surname submission.data[:surname]
              xml.Forename submission.data[:forename]
              xml.PartialDOB do                
                xml.Month submission.data[:dob_month]
                xml.Year submission.data[:dob_year]
              end
            end
            xml.CessationDate submission.data[:cessation_date]
            xml.RegisterEntryDate submission.data[:register_entry_date]
          end
        end
      end
    end
  end
end
  
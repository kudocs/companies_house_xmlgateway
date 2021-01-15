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
            if submission.data[:statement_type] == 'psc_linked' 
              xml.PSCLinkedStatement do
                xml.Statement submission.data[:statement]
                if submission.data[:linked_type] == 'person'
                  xml.Individual do
                    xml.Surname submission.data[:linked][:surname]
                    xml.Forename submission.data[:linked][:forename]
                    xml.PartialDOB do
                      xml.Month submission.data[:linked][:dob][:month]
                      xml.Year submission.data[:linked][:dob][:year]
                    end
                  end
                elsif submission.data[:linked_type] == 'rle'
                  xml.Corporate do
                    xml.CorporateName submission.data[:linked][:company_name]
                  end
                elsif submission.data[:linked_type] == 'orp'
                  xml.LegalPerson do
                    xml.LegalPersonName submission.data[:linked][:legal_name]
                  end
                end
              end
            end
            xml.RegisterEntryDate Time.now.strftime("%Y-%m-%d")
          end
        end
      end
    end
  end
end
module CompaniesHouseXmlgateway
  module Service
    class SecretaryResignation < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'OfficerResignation'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/...'
      
      # Generate the XML document that is embedded in the envelope for a Secretary Resignation action
      def build(submission)
        super do |xml|
          xml.ConfirmationStatement(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.ResignationDate submission.data[:resignation_date]
            xml.Secretary do 
              if submission.data[:corporate_name]
              xml.CorporateName submission.data[:corporate_name]
              end
              xml.Person do
                xml.Forename submission.data[:forename]
                xml.Surname submission.data[:surname]
                xml.DOB submission.data[:dob]
              end
            end
          end
        end
      end
    end
  end
end
  
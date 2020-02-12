module CompaniesHouseXmlgateway
  module Service
    class Accounts < CompaniesHouseXmlgateway::Service::Base
      API_CLASS_NAME = 'AccountsImage'
      def build(submission)
        super do |xml|
          xml.FormSubmission(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/Header',
            'xmlns:foo' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => 'http://xmlgw.companieshouse.gov.uk/Header http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/FormSubmission-v2-9.xsd'
          ) do
            xml.FormHeader do
              xml.CompanyNumber submission.company[:number]
              xml.CompanyType submission.company[:type]
              xml.CompanyName submission.company[:name]
              xml.CompanyAuthenticationCode submission.company[:auth_code]
              xml.PackageReference PACKAGE_REFERENCE
              xml.FormIdentifier 'Accounts'
              xml.SubmissionNumber submission.id
              xml.ContactName submission.company[:contact_name]
              xml.ContactNumber submission.company[:contact_number]
            end
            xml.Authority do
              xml.Designation 'DIR'
              xml.DateSigned Date.today.to_s 
            end            
            xml.Form do
            end            
              xml.Document do
                xml.Data submission.data[:doc_data]
                xml.Filename 'Accounts.xml'
                xml.ContentType "application/xml"
                xml.Category 'ACCOUNTS'
              end            
          end          
        end
      end
    end
  end
end
  
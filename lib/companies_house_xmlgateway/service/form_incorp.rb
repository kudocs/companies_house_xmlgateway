module CompaniesHouseXmlgateway
  module Service
    class FormIncorp < CompaniesHouseXmlgateway::Service::Base
      def build(submission)
        super do |xml|
          xml.FormSubmission(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/Header',
            'xmlns:foo' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => 'http://xmlgw.companieshouse.gov.uk/Header http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/FormSubmission-v2-9.xsd'
          ) do
            xml.FormHeader do             
              xml.CompanyName submission.company[:name]              
              xml.PackageReference PACKAGE_REFERENCE
              xml.FormIdentifier self.class::API_CLASS_NAME
              xml.SubmissionNumber submission.id              
            end
            xml.DateSigned Date.today.to_s
            xml.Form do
              yield xml
            end
            submission.company[:docs].each do |d|
              xml.Document do
                xml.Data d[:doc_data]
                xml.Filename d[:doc_name]
                xml.ContentType "application/pdf"
                xml.Category d[:doc_cat]
              end
            end
          end          
        end
      end
    end
  end
end
  
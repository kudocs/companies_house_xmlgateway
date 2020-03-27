module CompaniesHouseXmlgateway
  module Service
    class CompanyData < CompaniesHouseXmlgateway::Service::Base
      API_CLASS_NAME = 'CompanyDataRequest'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/CompanyData-v3-3.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.CompanyDataRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
           xml.CompanyNumber submission.data[:number]
           if submission.data[:company_prefix]
             xml.CompanyType submission.data[:company_prefix]
           end
           xml.CompanyAuthenticationCode submission.data[:auth_code]
           xml.MadeUpDate Time.now.strftime("%Y-%m-%d")
          end
        end
      end
    end
  end
end
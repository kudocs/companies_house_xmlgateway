module CompaniesHouseXmlgateway
  module Service
    class MemberData < CompaniesHouseXmlgateway::Service::BaseOther
      API_CLASS_NAME = 'MembersRegisterDataRequest'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/MembersRegisterData-v1-0.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.MembersRegisterDataRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
           xml.CompanyNumber submission.data[:number]
           xml.CompanyAuthenticationCode submission.data[:auth_code]           
          end
        end
      end
    end
  end
end
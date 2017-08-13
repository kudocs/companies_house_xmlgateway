module CompaniesHouseXmlgateway
  module Service
    class ChangeOfAddress < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ChangeRegisteredOfficeAddress'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1//schema/forms/ChangeRegisteredOfficeAddress-v2-5.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Address action
      def build(submission)
        super(submission) do |xml|
          xml.ChangeRegisteredOfficeAddress(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.Address do
              xml.Premise submission.data[:premises]
              xml.Street submission.data[:street]
              xml.Thoroughfare submission.data[:thoroughfare]
              xml.PostTown submission.data[:post_town]
              xml.Country submission.data[:country]
              xml.Postcode submission.data[:postcode]
              xml.CareofName submission.data[:care_of_name]
            end
          end
        end
      end
    end
  end
end
  
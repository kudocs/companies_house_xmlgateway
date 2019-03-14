module CompaniesHouseXmlgateway
  module Service
    class SailAddress < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'SailAddress'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/SailAddress-v2-5.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.SailAddress(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            #xml.SailAddress do
              xml.Address do
                xml.Premise submission.data[:premise]
                xml.Street submission.data[:street]
                if submission.data[:thoroughfare]
                  xml.Thoroughfare submission.data[:thoroughfare]
                end
                xml.PostTown submission.data[:post_town]
                if submission.data.has_key?(:other_country)
                  xml.OtherForeignCountry submission.data[:other_country]
                else
                  xml.Country submission.data[:country]
                end
                if submission.data[:postcode]
                    xml.Postcode submission.data[:postcode]
                end 
                if submission.data[:care_of_name]
                  xml.CareofName submission.data[:care_of_name]
                end
                if submission.data[:po_box]
                  xml.PoBox submission.data[:po_box]
                end                    
              end
            #end
          end
        end
      end
    end
  end
end
  

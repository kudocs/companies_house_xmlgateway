module CompaniesHouseXmlgateway
  module Service
    class ChangeAccountingReferenceDate < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ChangeAccountingReferenceDate'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/ChangeAccountingReferenceDate-v2-5.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.ChangeAccountingReferenceDate(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.SailAddress do
              xml.Address do
                xml.Premise submission.data[:address][:premise]
                xml.Street submission.data[:address][:street]
                if submission.data[:address][:thoroughfare]
                  xml.Thoroughfare submission.data[:address][:thoroughfare]
                end
                xml.PostTown submission.data[:address][:post_town]                          
                xml.Country submission.data[:address][:country]
                if submission.data[:address][:postcode]
                    xml.Postcode submission.data[:address][:postcode]
                end 
                if submission.data[:address][:care_of_name]
                  xml.CareofName submission.data[:address][:care_of_name]
                end
                if submission.data[:address][:po_box]
                  xml.PoBox submission.data[:address][:po_box]
                end                    
              end
            end
          end
        end
      end
    end
  end
end
  

module CompaniesHouseXmlgateway
  module Service
    class CorporateDirectorChangeDetails < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'OfficerChangeDetails'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/OfficerChangeDetails-v2-8.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Director Appointment action
      def build(submission)
        super do |xml|
          xml.OfficerChangeDetails(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.DateOfChange submission.data[:change_date]
            xml.Director do
              xml.Corporate do                
                xml.CorporateName submission.data[:corporate_name]                
                xml.Change do
                  #xml.Name do
                    #xml.Title
                    xml.CorporateName submission.data[:new_name] 
                    #xml.OtherForenames
                  #end
                  xml.Address do
                    xml.Premise submission.data[:address][:premise]
                    xml.Street submission.data[:address][:street]
                    if submission.data[:address][:thoroughfare]
                      xml.Thoroughfare submission.data[:address][:thoroughfare]
                    end
                    xml.PostTown submission.data[:address][:post_town]
                    #                    if submission.data[:service_address][:county]
                    #                     xml.County submission.data[:service_address][:county]
                    #                    end                    
                    xml.Country submission.data[:address][:country]
                    #xml.Postcode submission.data[:service_address][:postcode]
                    if submission.data[:address][:care_of_name]
                      xml.CareofName submission.data[:address][:care_of_name]
                    end
                    if submission.data[:address][:po_box]
                      xml.PoBox submission.data[:address][:po_box]
                    end                    
                  end
                  #                  
                  xml.CompanyIdentification do
                    if submission.data[:eea] 
                      xml.EEA do
                        xml.PlaceRegistered submission.data[:registered_place]
                        xml.RegistrationNumber submission.data[:reg_no]
                      end
                    else                  
                      xml.NonEEA do 
                        xml.PlaceRegistered submission.data[:registered_place]
                        xml.RegistrationNumber submission.data[:reg_no]
                        xml.LawGoverned submission.data[:law_gov]
                        xml.LegalForm submission.data[:legal_form]
                      end
                    end
                  end
                 
                end
              end
            end
          end
        end
      end
    end
  end
end
  
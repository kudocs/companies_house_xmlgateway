module CompaniesHouseXmlgateway
  module Service
    class CorporatePscNotification < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'PSCNotification'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/PSCNotification-v1-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Secretary Appointment action
      def build(submission)
        super do |xml|
          xml.PSCNotification(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.Corporate do
              xml.CorporateName submission.data[:corporate_name] 
              #xml.Title submission.data[:title]
              #xml.Forename submission.data[:forename]
              #                  if submission.data[:other_forenames]
              #                   xml.OtherForenames submission.data[:other_forenames]
              #                  end
              # xml.Surname submission.data[:surname]
              #                  xml.ServiceAddress do#submission.data[:service_address] #do
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
                if submission.data[:address].has_key?(:other_country)
                  xml.OtherForeignCountry submission.data[:address][:other_country]
                else
                  xml.Country submission.data[:address][:country]
                end
                if submission.data[:address][:postcode]
                  xml.Postcode submission.data[:address][:postcode]
                end 
                #xml.Postcode submission.data[:service_address][:postcode]
                if submission.data[:address][:care_of_name]
                  xml.CareofName submission.data[:address][:care_of_name]
                end
                if submission.data[:address][:po_box]
                  xml.PoBox submission.data[:address][:po_box]
                end
                  
              end
                   
              xml.PSCCompanyIdentification do
                if submission.data[:registered_place]
                  xml.PSCPlaceRegistered submission.data[:registered_place]
                end
                if submission.data[:reg_no]
                  xml.PSCRegistrationNumber submission.data[:reg_no]
                end
                xml.LawGoverned submission.data[:law_gov]
                xml.LegalForm submission.data[:legal_form]
                if submission.data[:country_or_state]
                  xml.CountryOrState submission.data[:country_or_state]
                end
                  
              end
          
            end
            xml.NatureOfControls do
              #ARRAY
              submission.data[:noc].each do |n|
                xml.NatureOfControl n
              end
            end
            xml.NotificationDate submission.data[:notification_date]
            xml.RegisterEntryDate submission.data[:register_entry_date]
          end
        end
      end
    end
  end
end
  
module CompaniesHouseXmlgateway
  module Service
    class PscNotification < CompaniesHouseXmlgateway::Service::Form
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
            xml.Individual do 
              xml.Forename submission.data[:forename]
              #                  if submission.data[:other_forenames]
              #                   xml.OtherForenames submission.data[:other_forenames]
              #                  end
              xml.Surname submission.data[:surname]
              xml.ServiceAddress do#submission.data[:service_address] #do
                xml.Address do
                  xml.Premise submission.data[:service_address][:premise]
                  xml.Street submission.data[:service_address][:street]
                  if submission.data[:service_address][:thoroughfare]
                    xml.Thoroughfare submission.data[:service_address][:thoroughfare]
                  end
                  xml.PostTown submission.data[:service_address][:post_town]
                  if submission.data[:service_address][:county]
                    xml.County submission.data[:service_address][:county]
                  end    
                  if submission.data[:service_address].has_key?(:other_country)
                    xml.OtherForeignCountry submission.data[:service_address][:other_country]
                  else
                    xml.Country submission.data[:service_address][:country]
                  end
                  xml.Postcode submission.data[:service_address][:postcode]
                  if submission.data[:service_address][:care_of_name]
                    xml.CareofName submission.data[:service_address][:care_of_name]
                  end
                  if submission.data[:service_address][:po_box]
                    xml.PoBox submission.data[:service_address][:po_box]
                  end                    
                end
                # xml.SameAsRegisteredOffice submission.data[:service_address][:service_addr_same]
              end
              xml.DOB submission.data[:dob]
              xml.Nationality submission.data[:nationality]             
              xml.CountryOfResidence submission.data[:country]
             
              xml.ResidentialAddress do#submission.data[:residential_address]#do
                xml.Address do
                  xml.Premise submission.data[:residential_address][:premise]
                  xml.Street submission.data[:residential_address][:street]
                  if submission.data[:residential_address][:thoroughfare]
                    xml.Thoroughfare submission.data[:residential_address][:thoroughfare]
                  end
                  xml.PostTown submission.data[:residential_address][:post_town]
                  if submission.data[:residential_address][:county]
                    xml.County submission.data[:residential_address][:county] 
                  end
                  if submission.data[:residential_address].has_key?(:other_country)
                    xml.OtherForeignCountry submission.data[:residential_address][:other_country]
                  else
                    xml.Country submission.data[:residential_address][:country]
                  end
                  xml.Postcode submission.data[:residential_address][:postcode]                 
                end
                # xml.SameAsRegisteredOffice submission.data[:residential_address][:residential_addr_same]
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
  
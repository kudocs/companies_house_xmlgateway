module CompaniesHouseXmlgateway
  module Service
    class SecretaryAppointment < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'OfficerAppointment'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/OfficerAppointment-v2-7.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Secretary Appointment action
      def build(submission)
        super do |xml|
          xml.OfficerAppointment(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.AppointmentDate submission.data[:appointment_date]
            xml.ConsentToAct submission.data[:consent_to_act]
            xml.Secretary do
              xml.Person do
                #xml.Title submission.data[:title]
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
                    xml.Country submission.data[:service_address][:country]
                    xml.Postcode submission.data[:service_address][:postcode]
                    if submission.data[:service_address][:care_of_name]
                      xml.CareofName submission.data[:service_address][:care_of_name]
                    end
                    if submission.data[:service_address][:po_box]
                      xml.PoBox submission.data[:service_address][:po_box]
                    end                    
                  end
                  #                    xml.SameAsRegisteredOffice submission.data[:service_address][:service_addr_same]
                end
                #xml.DOB submission.data[:dob]
#                xml.Nationality submission.data[:nationality]
#                xml.Occupation submission.data[:occupation]
#                xml.CountryOfResidence submission.data[:country]
                #                  xml.PreviousNames do
                #                    xml.Forename submission.data[:previous][:forename]
                #                    xml.Surname submission.data[:previous][:surname]
                #                  end
#                xml.ResidentialAddress do#submission.data[:residential_address]#do
#                  xml.Address do
#                    xml.Premise submission.data[:residential_address][:premise]
#                    xml.Street submission.data[:residential_address][:street]
#                    if submission.data[:residential_address][:thoroughfare]
#                      xml.Thoroughfare submission.data[:residential_address][:thoroughfare]
#                    end
#                    xml.PostTown submission.data[:residential_address][:post_town]
#                    if submission.data[:residential_address][:county]
#                      xml.County submission.data[:residential_address][:county] 
#                    end
#                    xml.Country submission.data[:residential_address][:country]
#                    xml.Postcode submission.data[:residential_address][:postcode]
#                    #xml.CareofName submission.data[:residential_address][:care_of_name]
#                    #xml.PoBox submission.data[:residential_address][:po_box]  
#                  end
#                  #                    xml.SameAsRegisteredOffice submission.data[:residential_address][:residential_addr_same]
#                end
              end
            end
          end
        end
      end
    end
  end
end
  
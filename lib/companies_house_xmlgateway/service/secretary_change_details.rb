module CompaniesHouseXmlgateway
  module Service
    class SecretaryChangeDetails < CompaniesHouseXmlgateway::Service::Form
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
            xml.Secretary do
              xml.Person do                
                xml.Surname submission.data[:surname]
                xml.Forename submission.data[:forename]              
                xml.Change do
                  xml.Name do
                    #xml.Title
                    xml.Surname submission.data[:new_surname]
                    xml.Forename submission.data[:new_forename]
                    #xml.OtherForenames
                  end
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
                                        xml.ResidentialAddressUnchangedInd false
                  end
                  #                  
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
                      xml.Country submission.data[:residential_address][:country]
                      xml.Postcode submission.data[:residential_address][:postcode]
                   
                    end
                    #                    xml.SameAsRegisteredOffice submission.data[:residential_address][:residential_addr_same]
                  end
                  #                  xml.ResidentialAddress do
                  #                    xml.SameAsServiceAddress
                  #                  end                  
                  xml.Nationality submission.data[:nationality]                  
                  xml.CountryOfResidence submission.data[:country]
                  xml.Occupation submission.data[:occupation]
                end
              end
            end
          end
        end
      end
    end
  end
end
  
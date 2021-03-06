module CompaniesHouseXmlgateway
  module Service
    class Incorporation < CompaniesHouseXmlgateway::Service::FormIncorp
      API_CLASS_NAME = 'CompanyIncorporation'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/CompanyIncorporation-v3-6.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Address action
      def build(submission)
        super(submission) do |xml|
          xml.CompanyIncorporation(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.CompanyType submission.data[:company_type]
#            xml.RegistersHeldOnPublicRecord do
#              xml.LLPMembers submission.data[:is_llp_reg] if submission.data[:is_llp_reg]
#              xml.LLPMembersURA submission.data[:is_llp_ura_reg] if submission.data[:is_llp_ura_reg]
#              xml.Directors false#submission.data[:is_dir_reg] if submission.data[:is_dir_reg]
#              xml.DirectorsURA false#submission.data[:is_dir_ura_reg] if submission.data[:is_dir_ura_reg]
#              xml.Secretaries false#submission.data[:is_sec_reg] if submission.data[:is_sec_reg]
#              xml.Members false#submission.data[:is_mem_reg] if submission.data[:is_mem_reg]
#              #if submission.data[:is_psc_reg]
#                xml.PSC do
#                  xml.StateNoObjection true
#                end
#              #end
#            end
          
            xml.CountryOfIncorporation submission.data[:location]
            
            xml.RegisteredOfficeAddress do
              xml.Premise submission.data[:office][:premises]
              xml.Street submission.data[:office][:street]
              xml.Thoroughfare submission.data[:office][:thoroughfare]
              xml.PostTown submission.data[:office][:post_town]
              xml.County  submission.data[:office][:region]
              xml.Country submission.data[:office][:country]
              xml.Postcode submission.data[:office][:postcode]
              xml.CareofName submission.data[:office][:care_of_name]
              xml.PoBox submission.data[:office][:po_box]
            end
            xml.DataMemorandum true
            xml.Articles submission.data[:articles] if submission.data[:articles]
            #the company has legal restriction on changes to its articles
            xml.RestrictedArticles submission.data[:restriction_articles] if submission.data[:restriction_articles]
            submission.data[:appointments].each do |a|
              xml.Appointment do 
                xml.ConsentToAct true#submission.data[:consent_to_act]
                if a[:officer_type] == 'director'
                xml.Director do
                  if a[:is_corp]
                    xml.Corporate do
                      xml.CorporateName a[:corporate_name]                
                      xml.Address do
                        xml.Premise a[:address][:premise]
                        xml.Street a[:address][:street]
                        if a[:address][:thoroughfare]
                          xml.Thoroughfare a[:address][:thoroughfare]
                        end
                        xml.PostTown a[:address][:post_town]
                        if a[:address].has_key?(:other_country)
                            xml.OtherForeignCountry a[:address][:other_country]
                          else     
                            xml.Country a[:address][:country]
                          end
                        if a[:address][:postcode]
                          xml.Postcode a[:address][:postcode]
                        end 
                
                        if a[:address][:care_of_name]
                          xml.CareofName a[:address][:care_of_name]
                        end
                        if a[:address][:po_box]
                          xml.PoBox a[:address][:po_box]
                        end
                  
                      end
                   
                      xml.CompanyIdentification do
                        if a[:is_eea] 
                          xml.UK do
                            #xml.PlaceRegistered a[:registered_place]
                            xml.RegistrationNumber a[:reg_no]
                          end
                        else                  
                          xml.NonUK do 
                            xml.PlaceRegistered a[:registered_place]
                            xml.RegistrationNumber a[:reg_no]
                            xml.LawGoverned a[:law_gov]
                            xml.LegalForm a[:legal_form]
                          end
                        end
                      end
               
                    end
                  else
                    xml.Person do  
                      xml.Title a[:title] if a[:title]
                      xml.Forename a[:forename]#               
                      xml.Surname a[:surname]
                      xml.ServiceAddress do
                        xml.Address do
                          xml.Premise a[:service_address][:premise]
                          xml.Street a[:service_address][:street]
                          if a[:service_address][:thoroughfare]
                            xml.Thoroughfare a[:service_address][:thoroughfare]
                          end
                          xml.PostTown a[:service_address][:post_town]
                          if a[:service_address][:county]
                            xml.County a[:service_address][:county]
                          end   
                          if a[:service_address].has_key?(:other_country)
                              xml.OtherForeignCountry a[:service_address][:other_country]
                            else   
                              xml.Country a[:service_address][:country]
                            end
                          xml.Postcode a[:service_address][:postcode]
                          if a[:service_address][:care_of_name]
                            xml.CareofName a[:service_address][:care_of_name]
                          end
                          if a[:service_address][:po_box]
                            xml.PoBox a[:service_address][:po_box]
                          end                    
                        end
                        #                    xml.SameAsRegisteredOffice submission.data[:service_address][:service_addr_same]
                      end
                      xml.DOB a[:dob]
                      xml.Nationality a[:nationality]
                      xml.Occupation a[:occupation]
                      xml.CountryOfResidence a[:country]

                      xml.ResidentialAddress do
                        xml.Address do
                          xml.Premise a[:residential_address][:premise]
                          xml.Street a[:residential_address][:street]
                          if a[:residential_address][:thoroughfare]
                            xml.Thoroughfare a[:residential_address][:thoroughfare]
                          end
                          xml.PostTown a[:residential_address][:post_town]
                          if a[:residential_address][:county]
                            xml.County a[:residential_address][:county] 
                          end
                          if a[:residential_address].has_key?(:other_country)
                              xml.OtherForeignCountry a[:residential_address][:other_country]
                            else   
                              xml.Country a[:residential_address][:country]
                            end
                          xml.Postcode a[:residential_address][:postcode]                    
                        end
                        #                    xml.SameAsRegisteredOffice submission.data[:residential_address][:residential_addr_same]
                      end
                    end
              
                  end
                end
              end
              if a[:officer_type] == 'secretary'
                #secretary start
                xml.Secretary do
                  if a[:is_corp]
                    xml.Corporate do
                      xml.CorporateName a[:corporate_name]                
                      xml.Address do
                        xml.Premise a[:address][:premise]
                        xml.Street a[:address][:street]
                        if a[:address][:thoroughfare]
                          xml.Thoroughfare a[:address][:thoroughfare]
                        end
                        xml.PostTown a[:address][:post_town]
                        if a[:address].has_key?(:other_country)
                            xml.OtherForeignCountry a[:address][:other_country]
                          else     
                            xml.Country a[:address][:country]
                          end
                        if a[:address][:postcode]
                          xml.Postcode a[:address][:postcode]
                        end 
                
                        if a[:address][:care_of_name]
                          xml.CareofName a[:address][:care_of_name]
                        end
                        if a[:address][:po_box]
                          xml.PoBox a[:address][:po_box]
                        end
                  
                      end
                   
                      xml.CompanyIdentification do
                        if a[:is_eea] 
                          xml.UK do
                            #xml.PlaceRegistered a[:registered_place]
                            xml.RegistrationNumber a[:reg_no]
                          end
                        else                  
                          xml.NonUK do 
                            xml.PlaceRegistered a[:registered_place]
                            xml.RegistrationNumber a[:reg_no]
                            xml.LawGoverned a[:law_gov]
                            xml.LegalForm a[:legal_form]
                          end
                        end
                      end
               
                    end
                  else
                    xml.Person do    
                      xml.Title a[:title] if a[:title]
                      xml.Forename a[:forename]#               
                      xml.Surname a[:surname]
                      xml.ServiceAddress do
                        xml.Address do
                          xml.Premise a[:service_address][:premise]
                          xml.Street a[:service_address][:street]
                          if a[:service_address][:thoroughfare]
                            xml.Thoroughfare a[:service_address][:thoroughfare]
                          end
                          xml.PostTown a[:service_address][:post_town]
                          if a[:service_address][:county]
                            xml.County a[:service_address][:county]
                          end 
                          if a[:service_address].has_key?(:other_country)
                              xml.OtherForeignCountry a[:service_address][:other_country]
                            else   
                              xml.Country a[:service_address][:country]
                            end
                          xml.Postcode a[:service_address][:postcode]
                          if a[:service_address][:care_of_name]
                            xml.CareofName a[:service_address][:care_of_name]
                          end
                          if a[:service_address][:po_box]
                            xml.PoBox a[:service_address][:po_box]
                          end                    
                        end
                        #                    xml.SameAsRegisteredOffice submission.data[:service_address][:service_addr_same]
                      end
#                      xml.DOB a[:dob]
#                      xml.Nationality a[:nationality]
#                      xml.Occupation a[:occupation]
#                      xml.CountryOfResidence a[:country]

#                      xml.ResidentialAddress do
#                        xml.Address do
#                          xml.Premise a[:residential_address][:premise]
#                          xml.Street a[:residential_address][:street]
#                          if a[:residential_address][:thoroughfare]
#                            xml.Thoroughfare a[:residential_address][:thoroughfare]
#                          end
#                          xml.PostTown a[:residential_address][:post_town]
#                          if a[:residential_address][:county]
#                            xml.County a[:residential_address][:county] 
#                          end
#                          xml.Country a[:residential_address][:country]
#                          xml.Postcode a[:residential_address][:postcode]                    
#                        end
#                        #                    xml.SameAsRegisteredOffice submission.data[:residential_address][:residential_addr_same]
#                      end
                    end
              
                  end
                end
                #secretary end
              end
              end
            end #of appointment array
            xml.PSCs do
              if submission.data[:no_psc]
                xml.NoPSCStatement "NO_INDIVIDUAL_OR_ENTITY_WITH_SIGNFICANT_CONTROL"
              else
              submission.data[:pscs].each do |p|
                xml.PSC do
                  xml.PSCNotification do
                    if p[:is_psc_corp]
                      xml.Corporate do
                        xml.CorporateName p[:corporate_name] 
              
                        xml.Address do
                          xml.Premise p[:address][:premise]
                          xml.Street p[:address][:street]
                          if p[:address][:thoroughfare]
                            xml.Thoroughfare p[:address][:thoroughfare]
                          end
                          xml.PostTown p[:address][:post_town]
                          if p[:address].has_key?(:other_country)
                            xml.OtherForeignCountry p[:address][:other_country]
                          else       
                            xml.Country p[:address][:country]
                          end
                          if p[:address][:postcode]
                            xml.Postcode p[:address][:postcode]
                          end 
                          #xml.Postcode p[:service_address][:postcode]
                          if p[:address][:care_of_name]
                            xml.CareofName p[:address][:care_of_name]
                          end
                          if p[:address][:po_box]
                            xml.PoBox p[:address][:po_box]
                          end
                  
                        end
                   
                        xml.PSCCompanyIdentification do
                          if p[:registered_place]
                            xml.PSCPlaceRegistered p[:registered_place]
                          end
                          if p[:reg_no]
                            xml.PSCRegistrationNumber p[:reg_no]
                          end
                          xml.LawGoverned p[:law_gov]
                          xml.LegalForm p[:legal_form]
                          if p[:country_or_state]
                            xml.CountryOrState p[:country_or_state]
                          end
                  
                        end
          
                      end
                    else
                      xml.Individual do 
                        xml.Title p[:title] if p[:title]
                        xml.Forename p[:forename]
                     
                        xml.Surname p[:surname]
                        xml.ServiceAddress do#p[:service_address] #do
                          xml.Address do
                            xml.Premise p[:service_address][:premise]
                            xml.Street p[:service_address][:street]
                            if p[:service_address][:thoroughfare]
                              xml.Thoroughfare p[:service_address][:thoroughfare]
                            end
                            xml.PostTown p[:service_address][:post_town]
                            if p[:service_address][:county]
                              xml.County p[:service_address][:county]
                            end  
                            if p[:service_address].has_key?(:other_country)
                              xml.OtherForeignCountry p[:service_address][:other_country]
                            else   
                              xml.Country p[:service_address][:country]
                            end
                            xml.Postcode p[:service_address][:postcode]
                            if p[:service_address][:care_of_name]
                              xml.CareofName p[:service_address][:care_of_name]
                            end
                            if p[:service_address][:po_box]
                              xml.PoBox p[:service_address][:po_box]
                            end                    
                          end
                          # xml.SameAsRegisteredOffice p[:service_address][:service_addr_same]
                        end
                        xml.DOB p[:dob]
                        xml.Nationality p[:nationality]             
                        xml.CountryOfResidence p[:country]
             
                        xml.ResidentialAddress do#p[:residential_address]#do
                          xml.Address do
                            xml.Premise p[:residential_address][:premise]
                            xml.Street p[:residential_address][:street]
                            if p[:residential_address][:thoroughfare]
                              xml.Thoroughfare p[:residential_address][:thoroughfare]
                            end
                            xml.PostTown p[:residential_address][:post_town]
                            if p[:residential_address][:county]
                              xml.County p[:residential_address][:county] 
                            end
                            if p[:residential_address].has_key?(:other_country)
                              xml.OtherForeignCountry p[:residential_address][:other_country]
                            else   
                              xml.Country p[:residential_address][:country]
                            end
                            xml.Postcode p[:residential_address][:postcode]                 
                          end
                          # xml.SameAsRegisteredOffice p[:residential_address][:residential_addr_same]
                        end
                        xml.ConsentStatement true
                      end
                    end #corp  or individual psc end
                    xml.NatureOfControls do
                      #ARRAY
                      p[:noc].each do |n|
                        xml.NatureOfControl n
                      end
                    end
#                    xml.NotificationDate p[:notification_date]
#                    xml.RegisterEntryDate p[:register_entry_date]                 
                  end
                end #of psc array
              end
              end
            end#PSC end
            if submission.data[:is_by_shares]
            #shareholdings start
            xml.StatementOfCapital do
              #TODO  in future when we handle multiple currency we need to extend the support
              submission.data[:statement_of_capital].each do |c|
              xml.Capital do
                xml.TotalAmountUnpaid c[:total_amount_unpaid]
                xml.TotalNumberOfIssuedShares c[:total_shares]
                xml.ShareCurrency c[:currency]
                xml.TotalAggregateNominalValue c[:total_nominal_value]
                #Total available shares along with the allotment
                c[:shares].each do |share|
                  xml.Shares do 
                    xml.ShareClass share[:share_class]
                    xml.PrescribedParticulars share[:pr_particulars]
                    xml.NumShares share[:shares_count]                   
                    xml.AggregateNominalValue  share[:agg_nominal_value]
                  end
                end
              end
            end
            end #shareholdings end 
            #start of subscribers
            submission.data[:subscribers].each_with_index do |s,i|
              xml.Subscribers do
                if s[:is_corp]
                  xml.Corporate do 
                    xml.Forename s[:first_name]
                    xml.Surname s[:sur_name]
                    xml.CorporateName s[:corp_name]
                  end
                else              
                  xml.Person do 
                    xml.Forename s[:first_name]
                    xml.Surname s[:sur_name]
                  end
                end
                xml.Address do
                  xml.Premise s[:address][:premise]
                  xml.Street s[:address][:street]
                  xml.Thoroughfare s[:address][:throughfare]
                  xml.PostTown s[:address][:post_town]
                  xml.County s[:address][:county]
                  if s[:address].has_key?(:other_country)
                    xml.OtherForeignCountry s[:address][:other_country]
                  else   
                    xml.Country s[:address][:country]
                  end
                  xml.Postcode s[:address][:postcode]
                end
                #array one
                s[:auth].each do |sa|
                  xml.Authentication do
                    xml.PersonalAttribute sa[:attribute]
                    xml.PersonalData sa[:personal_data]
                  end
                end
                s[:shares].each do |ss|
                  xml.Shares do
                    xml.ShareClass ss[:share_class]
                    xml.NumShares ss[:shares_count]
                    xml.AmountPaidDuePerShare ss[:paid]
                    xml.AmountUnpaidPerShare ss[:unpaid]
                    xml.ShareCurrency ss[:currency]
                    xml.ShareValue ss[:value]
                  end  
                end
                xml.MemorandumStatement submission.data[:memorandum_statement] if i.to_i == 0
              end #of subscribers
            end
          end
            if submission.data[:guarantors]
              submission.data[:guarantors].each_with_index do |g,i|
            
                #start of guarantors
                xml.Guarantors do
                  if g[:is_corp]
                    xml.Corporate do 
                      xml.Forename g[:first_name]
                      xml.Surname g[:sur_name]
                      xml.CorporateName g[:corp_name]
                    end
                  else
                    xml.Person do
                      xml.Forename g[:first_name]
                      xml.Surname g[:sur_name]
                    end
                  end
                  xml.Address do
                    xml.Premise g[:address][:premise]
                    xml.Street g[:address][:street]
                    xml.Thoroughfare g[:address][:throughfare]
                    xml.PostTown g[:address][:post_town]
                    xml.County g[:address][:county]
                    if g[:address].has_key?(:other_country)
                      xml.OtherForeignCountry g[:address][:other_country]
                    else   
                      xml.Country g[:address][:country]
                    end
                    xml.Postcode g[:address][:postcode]
                  end
                  g[:auth].each do |sa|
                    xml.Authentication do
                      xml.PersonalAttribute sa[:attribute]
                      xml.PersonalData sa[:personal_data]
                    end
                  end
                  xml.MemberClass g[:member_class] if g[:member_class]
                  xml.AmountGuaranteed  g[:amount_guart]  
                  xml.MemorandumStatement submission.data[:memorandum_statement] if i.to_i == 0
                end #of guarantors
              end            
            end
            if submission.data[:is_agent]
              xml.Authoriser do
                xml.Agent do
                  if submission.data[:agent][:is_corp]
                    xml.Corporate do 
                      xml.Forename submission.data[:agent][:first_name]
                      xml.Surname submission.data[:agent][:sur_name]
                      xml.CorporateName submission.data[:agent][:corp_name]
                    end
                  else
                    xml.Person do 
                      xml.Forename submission.data[:agent][:first_name]
                      xml.Surname submission.data[:agent][:sur_name]
                    end
                  end                  
                  submission.data[:agent][:auth].each do |sa|
                  xml.Authentication do
                    xml.PersonalAttribute sa[:attribute]
                    xml.PersonalData sa[:personal_data]
                  end
                end
                xml.Address do
                    xml.Premise submission.data[:agent][:address][:premise]
                    xml.Street submission.data[:agent][:address][:street]
                    xml.Thoroughfare submission.data[:agent][:address][:throughfare]
                    xml.PostTown submission.data[:agent][:address][:post_town]
                    xml.County submission.data[:agent][:address][:county]
                    if submission.data[:agent][:address].has_key?(:other_country)
                      xml.OtherForeignCountry submission.data[:agent][:address][:other_country]
                    else 
                      xml.Country submission.data[:agent][:address][:country]
                    end
                    xml.Postcode submission.data[:agent][:address][:postcode]
                  end
                end
              end
            else
             xml.Authoriser do               
             xml.Subscribers do
            submission.data[:authoriser].each do |a|
              #start of authorizers
             
                xml.Subscriber do
                  if a[:is_corp]
                    xml.Corporate do 
                      xml.Forename a[:first_name]
                      xml.Surname a[:sur_name]
                      xml.CorporateName a[:corp_name]
                    end
                  else
                    xml.Person do 
                      xml.Forename a[:first_name]
                      xml.Surname a[:sur_name]
                    end
                  end
                  a[:auth].each do |sa|
                  xml.Authentication do
                    xml.PersonalAttribute sa[:attribute]
                    xml.PersonalData sa[:personal_data]
                  end
                end
#                xml.Address do
#                    xml.Premise a[:address][:premise]
#                    xml.Street a[:address][:street]
#                    xml.Thoroughfare a[:address][:throughfare]
#                    xml.PostTown a[:address][:post_town]
#                    xml.County a[:address][:county]
#                    xml.Country a[:address][:country]
#                    xml.Postcode a[:address][:postcode]
#                  end
                end    
              
            end
            end #of subscribers
            end #of authorizers
            end #else of authorizers
            xml.SameDay submission.data[:same_day]
            xml.SameName submission.data[:same_name] if submission.data.has_key?(:same_name)
            xml.NameAuthorisation submission.data[:name_auth] if submission.data.has_key?(:name_auth)
            xml.RejectReference submission.data[:rej_ref] if submission.data.has_key?(:rej_ref)
            xml.SICCodes do
              submission.data[:sic].each do |c|
                #Array of Code
                xml.SICCode c
              end
            end 
            xml.StateSingleMemberCompany submission.data[:single_member] if submission.data[:single_member]
          end
        end
      end
    end
  end
end
  
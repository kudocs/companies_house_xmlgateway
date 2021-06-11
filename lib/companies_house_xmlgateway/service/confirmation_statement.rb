module CompaniesHouseXmlgateway
  module Service
    class ConfirmationStatement < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ConfirmationStatement'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/ConfirmationStatement-v1-2.xsd'
      
      # Generate the XML document that is embedded in the envelope for Confirmation Statement submission
      def build(submission)
        super do |xml|
          xml.ConfirmationStatement(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            if submission.data[:trading_on_market]
            xml.TradingOnMarket submission.data[:trading_on_market] 
            xml.DTR5Applies submission.data[:dtr5_applies] 
            xml.PSCExemptAsTradingOnRegulatedMarket submission.data[:psc1] 
            xml.PSCExemptAsSharesAdmittedOnMarket submission.data[:psc2]
            xml.PSCExemptAsTradingOnUKRegulatedMarket submission.data[:psc3]
            end
            xml.ReviewDate Date.today.to_s
            if submission.data[:sic_codes]
              xml.SICCodes do
                submission.data[:sic_codes].each do |c|
                  xml.SICCode c
                end
              end
            end
            if submission.data[:capital]
              xml.StatementOfCapital do
                submission.data[:capital].each do |c|
                  xml.Capital do                      
                    xml.TotalAmountUnpaid c[:total_amount_unpaid]
                    xml.TotalNumberOfIssuedShares c[:total_shares_issued]
                    xml.ShareCurrency c[:share_currency]
                    xml.TotalAggregateNominalValue c[:total_agg_nominal_value]
                    c[:shares].each do |s|
                      xml.Shares do
                        xml.ShareClass s[:share_class]
                        xml.PrescribedParticulars s[:particulars]
                        xml.NumShares s[:num_shares]
                        xml.AggregateNominalValue s[:agg_nominal_value]
                      end
                    end
                  end
                end
              end
            end
            if submission.data[:shareholdings]
              submission.data[:shareholdings].each do |h|
                xml.Shareholdings do
                  xml.ShareClass h[:share_class]
                  xml.NumberHeld h[:number_held]
                  if h[:transfers]
                    h[:transfers].each do |t|
                      xml.Transfers do
                        xml.DateOfTransfer t[:date_of_transfer]
                        xml.NumberSharesTransferred t[:number_shares_transferred]
                      end
                    end
                  end
                  h[:shareholders].each do |s|
                    xml.Shareholders do
                      xml.Name do
                        if s[:is_a_name]
                          xml.AmalgamatedName s[:a_name]
                        else                        
                          xml.Surname s[:sur_name]
                          xml.Forename s[:first_name] if s[:first_name] != ''                     
                        end
                      end
                      if s[:is_ser_addr]
                        xml.Address do
                          xml.Premise s[:address][:premise]
                          xml.Street s[:address][:street]
                          xml.Thoroughfare s[:address][:throughfare]
                          xml.PostTown s[:address][:post_town]
                          xml.County s[:address][:county]
                          xml.Country s[:address][:country]
                          xml.Postcode s[:address][:postcode]
                        end
                      end
                    end
                  end
                end
              end
            end            
            xml.StateConfirmation 'true'
          end
        end
      end
    end
  end
end
  
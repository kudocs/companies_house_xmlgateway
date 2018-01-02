module CompaniesHouseXmlgateway
  module Service
    class ConfirmationStatement < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ConfirmationStatement'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/ConfirmationStatement-v1-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for Confirmation Statement submission
      def build(submission)
        super do |xml|
          xml.ConfirmationStatement(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.TradingOnMarket submission.data[:trading_on_market] if submission.data[:trading_on_market]
            xml.DTR5Applies submission.data[:dtr5_applies] if submission.data[:dtr5_applies]
            xml.PSCExemptAsTradingOnRegulatedMarket submission.data[:psc1] if submission.data[:psc1]
            xml.PSCExemptAsSharesAdmittedOnMarket submission.data[:psc2] if submission.data[:psc2]
            xml.PSCExemptAsTradingOnUKRegulatedMarket submission.data[:psc3] if submission.data[:psc3]
            xml.ReviewDate Date.today.to_s
            if submission.data[:siccode]
              xml.SICCodes do
                xml.SICCode submission.data[:siccode]
              end
            end
            if submission.data[:capital]
              xml.StatementOfCapital do
                submission.data[:capital].each do |c|
                  xml.Capital do                      
                    xml.TotalAmountUnpaid c[:total_amount_paid]
                    xml.TotalNumberOfIssuedShares c[:total_shares_issued]
                    xml.ShareCurrency c[:share_currency]
                    xml.TotalAggregateNominalValue c[:total_agg_nominal_value]
                    xml.Shares do
                      xml.ShareClass c[:share_class]
                      xml.PrescribedParticulars c[:particulars]
                      xml.NumShares c[:num_shares]
                      xml.AggregateNominalValue c[:agg_nominal_value]
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
                  h[:transfers].each do |t|
                    xml.Transfers do
                      xml.DateOfTransfer t[:date_of_transfer]
                      xml.NumberSharesTransferred t[:number_shares_transferred]
                    end
                  end
                  h[:shareholders].each do |s|
                    xml.Shareholders do
                      xml.Name do
                        xml.Forename s[:first_name]
                        xml.Surname s[:sur_name]
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
  
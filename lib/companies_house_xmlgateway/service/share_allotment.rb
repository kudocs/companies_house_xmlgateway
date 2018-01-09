module CompaniesHouseXmlgateway
  module Service
    class ShareAllotment < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'ReturnofAllotmentShares'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/forms/ReturnofAllotmentShares-v3-0.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Secretary Appointment action
      def build(submission)
        super do |xml|
          xml.ReturnofAllotmentShares(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do

            xml.StartPeriodSharesAllotted submission.data[:start_date]
            xml.StatementOfCapital do
              #TODO  in future when we handle multiple currency we need to extend the support
              xml.Capital do
                xml.TotalAmountUnpaid submission.data[:statement_of_capital][:total_amount_unpaid]
                xml.TotalNumberOfIssuedShares submission.data[:statement_of_capital][:total_shares]
                xml.ShareCurrency submission.data[:statement_of_capital][:currency]
                xml.TotalAggregateNominalValue submission.data[:statement_of_capital][:total_nominal_value]
                #Total available shares along with the allotment
                submission.data[:statement_of_capital][:shares].each do |share|
                  xml.Shares do 
                    xml.ShareClass share[:share_class]
                    xml.PrescribedParticulars share[:pr_particulars]
                    xml.NumShares share[:shares_count]                    
                    xml.AggregateNominalValue  share[:agg_nominal_value]
                  end
                end
              end
            end   
            #New Shares for each person in the Process
            submission.data[:allotments].each do |allotment|
              xml.Allotment do
                xml.ShareClass allotment[:share_class]
                xml.NumShares allotment[:shares_count]
                xml.AmountPaidDuePerShare allotment[:paid]
                xml.AmountUnpaidPerShare allotment[:due]
                xml.ShareCurrency allotment[:currency]
                xml.ShareValue allotment[:share_value]
                xml.Consideration allotment[:consideration]
              end
            end
          end
        end
      end
    end
  end
end
  
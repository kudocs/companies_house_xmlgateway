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
            xml.AccountRefDate submission.data[:ref_date]
            xml.ChangeToPeriod submission.data[:period] 
            xml.AmendedAccountRefDate submission.data[:new_ref_date]
            if submission.data[:ext]
              xml.FiveYearExtensionDetails do  
                xml.ExtensionReason submission.data[:ext][:reason]
                xml.ExtensionAuthorisedCode submission.data[:ext][:au_code]
              end
            end
          end
        end
      end
    end
  end
end
  
module CompaniesHouseXmlgateway
  module Service
    class Mortgages < CompaniesHouseXmlgateway::Service::BaseName
      API_CLASS_NAME = 'Mortgages'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v1-0/schema/Mortgages-v2-4.xsd'
      
      
      def build(submission)
        super do |xml|
          xml.MortgagesRequest(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk/v1-0',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "#{SCHEMA_XSD}"
          ) do
            #xml.OfficerAppointment do
              xml.CompanyName submission.data[:name]
              xml.CompanyNumber submission.data[:company_number]
              xml.UserReference submission.data[:ref]
              xml.SatisfiedChargesInd submission.data[:satisfied_charges] if submission.data[:satisfied_charges]
              xml.StartDate submission.data[:start_date] if submission.data[:start_date]
              xml.EndDate  submission.data[:end_date] if submission.data[:end_date] 
              xml.ContinuationKey submission.data[:ckey] if submission.data[:ckey]               
          end
        end
      end
    end
  end
end
  
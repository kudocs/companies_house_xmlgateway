module CompaniesHouseXmlgateway
  module Service
    class SubmissionStatusSpecific < CompaniesHouseXmlgateway::Service::Base
      API_CLASS_NAME = 'GetSubmissionStatus'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/GetSubmissionStatus-v2-8.xsd'
      
      # Generate the XML for a request for submission statuses of outstanding submissions
      def build(submission)
        super do |xml|
          xml.GetSubmissionStatus(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.SubmissionNumber submission.company[:sub_no]
            xml.PresenterID Digest::MD5.hexdigest(CompaniesHouseXmlgateway.config.presenter_id)
          end
        end
      end
    end
  end
end
  
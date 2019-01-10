module CompaniesHouseXmlgateway
  module Service
    class ChangeOfName < CompaniesHouseXmlgateway::Service::FormNameChange
      API_CLASS_NAME = 'ChangeOfName'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/ChangeOfName-v2-5-1.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Name action
      def build(submission)
        super do |xml|
          xml.ChangeOfName(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            xml.MethodOfChange submission.data[:method]
            xml.ProposedCompanyName submission.data[:proposed_name]
            if submission.data[:meeting_date]
              xml.MeetingDate submission.data[:meeting_date]
            end
            xml.SameDay submission.data[:same_day]
            xml.NoticeGiven submission.data[:notice_given]
          end
        end
      end
    end
  end
end
  
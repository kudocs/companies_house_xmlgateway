module CompaniesHouseXmlgateway
  module Service
    class ChangeOfLocation < CompaniesHouseXmlgateway::Service::Form
      API_CLASS_NAME = 'RecordChangeOfLocation'
      SCHEMA_XSD = 'http://xmlgw.companieshouse.gov.uk/v2-1/schema/forms/SailAddress-v2-5.xsd'
      
      # Generate the XML document that is embedded in the envelope for a Change Ref Date action
      def build(submission)
        super do |xml|
          xml.RecordChangeOfLocation(
            'xmlns' => 'http://xmlgw.companieshouse.gov.uk',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
            'xsi:schemaLocation' => "http://xmlgw.companieshouse.gov.uk #{SCHEMA_XSD}"
          ) do
            if submission.data[:form_type] == '3'
              xml.MoveToSAILAddress true
            elsif submission.data[:form_type] == '4'
              xml.MoveToRegisteredOffice true
              if submission.data[:remove_sail]
                xml.RemoveSAILAddressInd true
              end
            end 
            submission.data[:document_type].split(',').each do |d|
              xml.RegisterList do
                xml.RecordType d
              end
            end
          end
        end
      end
    end
  end
end
  

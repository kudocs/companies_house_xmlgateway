require 'nokogiri'

module CompaniesHouseXmlgateway
  module Service
    class BaseName
      ENVELOPE_VERSION = '1.0';
      QUALIFIER = 'request';
      AUTHENTICATION_METHOD = 'CHMD5';
      API_CLASS_NAME = 'Base'
      PACKAGE_REFERENCE = '0012'
      TRANS_ID = Time.now.to_i
      #<GovTalkMessage xsi:schemaLocation="http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader http://xmlgw.companieshouse.gov.uk/v1-0/schema/Egov_ch.xsd" xmlns="http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#" xmlns:gt="http://www.govtalk.gov.uk/schemas/govtalk/core" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
      # Generate XML envelope and use a block to generate the Form XML that is subsequently injected
      def build(submission)
        builder = Nokogiri::XML::Builder.new { |xml|
          xml.GovTalkMessage(
            'xsi:schemaLocation' => 'http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader http://xmlgw.companieshouse.gov.uk/v1-0/schema/Egov_ch.xsd',
            'xmlns' => 'http://www.govtalk.gov.uk/schemas/govtalk/govtalkheader',
            'xmlns:dsig' => 'http://www.w3.org/2000/09/xmldsig#',
            'xmlns:gt' => 'http://www.govtalk.gov.uk/schemas/govtalk/core',
            'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance'
          ) do
            xml.EnvelopeVersion ENVELOPE_VERSION
            xml.Header do
              xml.MessageDetails do
                xml.Class self.class::API_CLASS_NAME
                xml.Qualifier QUALIFIER
                xml.TransactionID TRANS_ID
                #xml.GatewayTest CompaniesHouseXmlgateway.config.test_mode ? 1 : 0
              end
              xml.SenderDetails do
                xml.IDAuthentication do
                  xml.SenderID 'XMLGatewayTestUserID'
                  xml.Authentication do
                    xml.Method AUTHENTICATION_METHOD
                    xml.Value Digest::MD5.hexdigest('XMLGatewayTestUserID'+'XMLGatewayTestPassword'+TRANS_ID.to_s)
                  end
                end
              end
            end
            xml.GovTalkDetails do
              xml.Keys ''
            end
            xml.Body do
              yield xml
            end
          end
        }
        builder.to_xml
      end
    end
  end
end
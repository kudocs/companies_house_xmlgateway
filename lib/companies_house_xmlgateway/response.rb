require 'nokogiri'

module CompaniesHouseXmlgateway
  class Response
    attr_reader :success, :errors, :statuses, :submission, :response_end_point, :response_poll_interval, 
                :correlation_id, :gateway_timestamp, :raw_body, :document
    
    # Create a new Response object using the body of the response returned by Faraday
    def initialize(submission, response)
      @submission = submission
      @xml_doc = Nokogiri::XML(response.body)
      @raw_body = response.body
      
      parse_response
      parse_errors
      
      @success = @errors.empty?
    end
    
    private
    
      # Extract the useful data from the response XML and attach them to instance variables
      def parse_response
        unless (node = @xml_doc.at_css('Header MessageDetails ResponseEndPoint')).nil?
          @response_end_point = node.text.strip
          @response_poll_interval = node.attr('PollInterval').to_i
        end

        unless (node = @xml_doc.at_css('Header MessageDetails CorrelationID')).nil?
          @correlation_id = node.text.strip
        end

        unless (node = @xml_doc.at_css('Header MessageDetails GatewayTimestamp')).nil?
          @gateway_timestamp = node.text.strip
        end

        unless (node = @xml_doc.at_css('Body SubmissionStatus Status')).nil?
          @statuses = []
          @xml_doc.css('Body SubmissionStatus Status').each do |status|
            
            s = {
              submission_id: status.at_css('SubmissionNumber').text.strip,
              status_code: status.at_css('StatusCode').text.strip,
              rejections: status.css('Rejections Reject').collect{ |reject|
                {
                  reject_code: reject.at_css('RejectCode'),
                  description: reject.at_css('Description'),
                  instance_number: reject.at_css('InstanceNumber')
                }.transform_values {|v| v.nil? ? nil : v.text.strip }
              },
              examiner: {
                telephone: status.at_css('Examiner Telephone'),
                comment: status.at_css('Examiner Comment')
              }.transform_values {|v| v.nil? ? nil : v.text.strip }
            }           
            @statuses << s
          end
          if !@xml_doc.at_css('Body SubmissionStatus Status IncorporationDetails').nil?
            @xml_doc.css('Body SubmissionStatus Status').each do |status|
              s = {
                company_number: status.at_css('CompanyNumber'),
                document: status.at_css('IncorporationDetails DocRequestKey'),
                incorp_date: status.at_css('IncorporationDetails IncorporationDate'),
                authentication_code: status.at_css('IncorporationDetails AuthenticationCode')              
              }.transform_values {|v| v.nil? ? nil : v.text.strip }
              @statuses << s
            end
          end          
        end
        
        unless (node = @xml_doc.at_css('Body Document')).nil?          
          @xml_doc.css('Body Document').each do |status|
            @document = {
              company_number: status.at_css('CompanyNumber'),
              doc_date: status.at_css('DocumentDate'),
              doc_id: status.at_css('DocumentID'),
              doc_data: status.at_css('DocumentData')              
            }.transform_values {|v| v.nil? ? nil : v.text.strip }            
          end
        end
      end
    
      # Extract the Errors from the response XML and return them as an array of hashes
      def parse_errors
        @errors = []
        @xml_doc.css('GovTalkDetails GovTalkErrors Error').each do |error|
          raised_by = error.at_css('RaisedBy')
          @errors << {
            raised_by: error.at_css('RaisedBy'),
            number: error.at_css('Number'),
            type: error.at_css('Type'),
            text: error.at_css('Text'),
            location: error.at_css('Location')
          }.transform_values {|v| v.nil? ? nil : v.text.strip }
        end
      end
  end
end
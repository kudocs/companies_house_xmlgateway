require 'nokogiri'
require 'faraday'

module CompaniesHouseXmlgateway
  class Client
    attr_accessor :timeout, :logger
    
    API_HTTPS_URL = 'https://xmlgw.companieshouse.gov.uk'
    #API_URL = 'http://127.0.0.1:5000'
    #API_URL = 'http://xmlgw.companieshouse.gov.uk'
    API_URL = 'http://xmlgw.companieshouse.gov.uk'
    
    ACTIONS =  {
      change_of_address: CompaniesHouseXmlgateway::Service::ChangeOfAddress,
      change_of_name: CompaniesHouseXmlgateway::Service::ChangeOfName,
      confirmation_statement: CompaniesHouseXmlgateway::Service::ConfirmationStatement,
      director_appointment: CompaniesHouseXmlgateway::Service::DirectorAppointment,
      secretary_appointment: CompaniesHouseXmlgateway::Service::SecretaryAppointment,
      member_appointment: CompaniesHouseXmlgateway::Service::MemberAppointment,
      director_change_details: CompaniesHouseXmlgateway::Service::DirectorChangeDetails,
      secretary_change_details: CompaniesHouseXmlgateway::Service::SecretaryChangeDetails,
      member_change_details: CompaniesHouseXmlgateway::Service::MemberChangeDetails,
      corporate_director_appointment: CompaniesHouseXmlgateway::Service::CorporateDirectorAppointment,
      corporate_secretary_appointment: CompaniesHouseXmlgateway::Service::CorporateSecretaryAppointment,
      corporate_member_appointment: CompaniesHouseXmlgateway::Service::CorporateMemberAppointment,
      corporate_director_change_details: CompaniesHouseXmlgateway::Service::CorporateDirectorChangeDetails,
      corporate_secretary_change_details: CompaniesHouseXmlgateway::Service::CorporateSecretaryChangeDetails,
      corporate_member_change_details: CompaniesHouseXmlgateway::Service::CorporateMemberChangeDetails,      
      director_resignation: CompaniesHouseXmlgateway::Service::DirectorResignation,
      secretary_resignation: CompaniesHouseXmlgateway::Service::SecretaryResignation,
      share_allotment: CompaniesHouseXmlgateway::Service::ShareAllotment,
      change_ref_date: CompaniesHouseXmlgateway::Service::ChangeAccountingReferenceDate,
      psc_notification: CompaniesHouseXmlgateway::Service::PscNotification,
      psc_cessation: CompaniesHouseXmlgateway::Service::PscCessation,
      psc_change_details: CompaniesHouseXmlgateway::Service::PscChangeDetails,
      corporate_psc_notification: CompaniesHouseXmlgateway::Service::CorporatePscNotification,
      corporate_psc_cessation: CompaniesHouseXmlgateway::Service::CorporatePscCessation,
      corporate_psc_change_details: CompaniesHouseXmlgateway::Service::CorporatePscChangeDetails,
      name_search: CompaniesHouseXmlgateway::Service::NameSearch,
      file_history: CompaniesHouseXmlgateway::Service::FileHistory,
      document_info: CompaniesHouseXmlgateway::Service::DocumentInfo,
      document_request: CompaniesHouseXmlgateway::Service::DocumentRequest,
      company_data: CompaniesHouseXmlgateway::Service::CompanyData,
      member_data: CompaniesHouseXmlgateway::Service::MemberData,
      incorporation: CompaniesHouseXmlgateway::Service::Incorporation,
      submission_status_specific: CompaniesHouseXmlgateway::Service::SubmissionStatusSpecific,
      sail_address: CompaniesHouseXmlgateway::Service::SailAddress,
      get_document: CompaniesHouseXmlgateway::Service::GetDocument,
      mortages: CompaniesHouseXmlgateway::Service::Mortgages,
      accounts: CompaniesHouseXmlgateway::Service::Accounts,
      change_of_location: CompaniesHouseXmlgateway::Service::ChangeOfLocation,
      psc_statement_notification: CompaniesHouseXmlgateway::Service::PscStatementNotification,
      psc_statement_withdrawal: CompaniesHouseXmlgateway::Service::PscStatementWithdrawal
    }
    
    # Define the Perform method for each of the actions supported by the Client
    ACTIONS.each do |k, v|
      define_method "perform_#{k}" do |company, data|
        perform_action(v, company, data)
      end
    end
    
    # Define the Preview method for each of the actions supported by the Client
    ACTIONS.each do |k, v|
      define_method "preview_#{k}" do |company, data|
        preview_action(v, company, data)
      end
    end
    
    # Return statuses for submissions previously sent using the clients Presenter ID (MAX 20 submissions per request)
    def get_submission_status
      submission = CompaniesHouseXmlgateway::StatusSubmission.new
    
      service = CompaniesHouseXmlgateway::Service::SubmissionStatus.new
      submission.xml = service.build(submission)
    
      make_http_request(submission)
    end
    
    # Send a Submission Acknowledgement to the API in order to release any new statuses and clear old ones
    def acknowledge_submission_status
      submission = CompaniesHouseXmlgateway::StatusSubmission.new
    
      service = CompaniesHouseXmlgateway::Service::AcknowledgeSubmissionStatus.new
      submission.xml = service.build(submission)
    
      make_http_request(submission)
    end
    
    private
    
      # Create a Submission record
      def perform_action(service_class, company, data)
      submission = CompaniesHouseXmlgateway::FormSubmission.new(company, data)
      
      service = service_class.new
      submission.xml = service.build(submission)
      if (service_class.to_s == "CompaniesHouseXmlgateway::Service::NameSearch" or service_class.to_s == "CompaniesHouseXmlgateway::Service::Mortgages" or service_class.to_s == "CompaniesHouseXmlgateway::Service::FileHistory" or service_class.to_s == "CompaniesHouseXmlgateway::Service::DocumentInfo")
        make_http_request(submission)
      else
        make_https_request(submission)
      end
    end
    
      # Create a Submission preview record
      def preview_action(service_class, company, data)
        submission = CompaniesHouseXmlgateway::FormSubmission.new(company, data)        
        service = service_class.new
        submission.xml = service.build(submission)
        return submission
      end 
    
      # Use Faraday to send the submission document to the Gateway
      def make_http_request(submission)
        p submission.xml
        conn = build_connection
        begin
          res = conn.post do |req|
            req.url '/v1-0/xmlgw/Gateway'
            req.headers['Content-Type'] = 'text/xml'
            req.body = submission.xml
          end
          return CompaniesHouseXmlgateway::Response.new(submission, res)
        rescue Faraday::Error::ConnectionFailed => e
          
        end
      end
      
      # Create a new Faraday instance using the endpoint URL
      def build_connection
        Faraday.new(:url => API_URL)
      end
      
      # Use Faraday to send the submission document to the Gateway using HTTPS
      def make_https_request(submission)
        p submission.xml
        conn = build_https_connection
        begin
          res = conn.post do |req|
            req.url '/v1-0/xmlgw/Gateway'
            req.headers['Content-Type'] = 'text/xml'
            req.body = submission.xml
          end
          return CompaniesHouseXmlgateway::Response.new(submission, res)
        rescue Faraday::Error::ConnectionFailed => e
          
        end
      end
      
      # Create a new Faraday instance using the endpoint URL using HTTPS
      def build_https_connection
        Faraday.new(:url => API_HTTPS_URL)
      end
  end
end
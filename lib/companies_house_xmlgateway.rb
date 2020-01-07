require 'companies_house_xmlgateway/service/base'
require 'companies_house_xmlgateway/service/form'
require 'companies_house_xmlgateway/service/base_other'
require 'companies_house_xmlgateway/service/base_name'
require 'companies_house_xmlgateway/service/base_mortage'
require 'companies_house_xmlgateway/service/file_base'
require 'companies_house_xmlgateway/service/form_other'
require 'companies_house_xmlgateway/service/form_share'
require 'companies_house_xmlgateway/service/form_incorp'
require 'companies_house_xmlgateway/service/form_name_change'
require "companies_house_xmlgateway/service/change_accounting_reference_date"
require "companies_house_xmlgateway/service/change_of_address"
require "companies_house_xmlgateway/service/change_of_name"
require "companies_house_xmlgateway/service/confirmation_statement"
require "companies_house_xmlgateway/service/director_appointment"
require "companies_house_xmlgateway/service/secretary_appointment"
require "companies_house_xmlgateway/service/member_appointment"
require "companies_house_xmlgateway/service/director_change_details"
require "companies_house_xmlgateway/service/secretary_change_details"
require "companies_house_xmlgateway/service/member_change_details"
require "companies_house_xmlgateway/service/director_resignation"
require "companies_house_xmlgateway/service/secretary_resignation"
require "companies_house_xmlgateway/service/corporate_director_appointment"
require "companies_house_xmlgateway/service/corporate_secretary_appointment"
require "companies_house_xmlgateway/service/corporate_member_appointment"
require "companies_house_xmlgateway/service/corporate_director_change_details"
require "companies_house_xmlgateway/service/corporate_secretary_change_details"
require "companies_house_xmlgateway/service/corporate_member_change_details"
require "companies_house_xmlgateway/service/submission_status"
require "companies_house_xmlgateway/service/share_allotment"
require "companies_house_xmlgateway/service/change_accounting_reference_date"
require "companies_house_xmlgateway/service/psc_notification"
require "companies_house_xmlgateway/service/psc_cessation"
require "companies_house_xmlgateway/service/psc_change_details"
require "companies_house_xmlgateway/service/corporate_psc_cessation"
require "companies_house_xmlgateway/service/corporate_psc_notification"
require "companies_house_xmlgateway/service/corporate_psc_change_details"
require "companies_house_xmlgateway/service/name_search"
require "companies_house_xmlgateway/service/file_history"
require "companies_house_xmlgateway/service/document_info"
require "companies_house_xmlgateway/service/document_request"
require "companies_house_xmlgateway/service/company_data"
require "companies_house_xmlgateway/service/member_data"
require "companies_house_xmlgateway/service/incorporation"
require "companies_house_xmlgateway/service/sail_address"
require "companies_house_xmlgateway/service/submission_status_specific"
require "companies_house_xmlgateway/service/acknowledge_submission_status"
require "companies_house_xmlgateway/service/get_document"
require "companies_house_xmlgateway/service/mortages"
require "companies_house_xmlgateway/service/accounts"
require "companies_house_xmlgateway/version"
require "companies_house_xmlgateway/config"
require "companies_house_xmlgateway/client"
require "companies_house_xmlgateway/form_submission"
require "companies_house_xmlgateway/status_submission"
require "companies_house_xmlgateway/response"

module CompaniesHouseXmlgateway
  class << self
    def config
      @config ||= CompaniesHouseXmlgateway::Config.instance
      yield @config if block_given?
      @config
    end
    
    def client
      @client ||= CompaniesHouseXmlgateway::Client.new
    end
  end
end

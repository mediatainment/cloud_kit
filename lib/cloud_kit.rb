require 'httparty'
require 'create_operation.rb'
require 'modify_operation.rb'

class CloudKit
  include HTTParty
  
  base_uri 'https://api.apple-cloudkit.com'
  format :json
  headers 'Content-Type' => 'application/json'
  
  #debug_output $stdout
  
  attr_writer :session_token

  def initialize(api_token, container, environment = "production", database = "public", version = 1)
    @api_token = api_token
    @container = container
    @environment = environment
    @database = database
    @version = version
  end
  
  def modify(operations, user_options = {})    
    options = {:body => {:operations => operations}.to_json, :query => auth_options}
    options.merge! user_options
    response = self.class.post("#{uri_base}/records/modify", options)
    
    # Requires authentication
    if response.code == 421
      puts "Authentication required: #{response.parsed_response["redirectURL"]}"
    end
    
    response
  end
  
  def query(record_type, filter_by = nil, sort_by = nil, user_options = {})
    query_options = {:recordType => record_type}
    query_options[:filterBy] = filter_by if filter_by
    query_options[:sortBy] = sort_by if sort_by
    
    options = {:body => {:query => query_options}.to_json, :query => auth_options}
    options.merge! user_options
    self.class.post("#{uri_base}/records/query", options)    
  end
  
  def lookup(record_names, user_options = {})
    records = []
    record_names.each do |record_name|
      records << {:recordName => record_name}
    end
    
    options = {:body => {:records => records}.to_json, :query => auth_options}
    options.merge! user_options
    self.class.post("#{uri_base}/records/lookup", options)    
  end
  
  private 
    def uri_base
      "/database/#{@version}/#{@container}/#{@environment}/#{@database}"
    end
  
  
    def auth_options
      {"ckAPIToken" => @api_token, "ckSession" => @session_token}
    end
end

require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
    :cas_base_url => "https://67.23.79.76/",
    :username_session_key => :cas_email,
    :logger => Rails.logger
) 
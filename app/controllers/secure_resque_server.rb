require 'resque/server'

class SecureResqueServer < Resque::Server

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['sitetools', 'sitetools']
  end
  
end
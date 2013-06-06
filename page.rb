require 'nokogiri'
require 'open-uri'
require 'net/http'
require "html_spellchecker"
require 'ffi/hunspell'

start_time = Time.now()

# Do funky things with it using Nokogiri::XML::Node methods...

# # HTML_Spellchecker method
# results = HTML_Spellchecker.english.spellcheck("<p>This is xzqwy.</p>")

# # words check
# suggestions = []
# FFI::Hunspell.dict do |dict|
# 	wait_for_check = 'doggg is on the dest'
#   unless dict.check?(wait_for_check)
#   	suggestions = dict.suggest(wait_for_check)
#   end
# end
# p 'spend time: ' + (Time.now() - start_time).to_s
# p suggestions
####
# Get a Nokogiri::HTML::Document for the page we’re interested in...

doc = Nokogiri::HTML(open('http://www.yahoo.com'))
# Search for nodes by css
# Check whether links are broken or not
doc.css('a').each do |link|
  link.each do |attr_value|
  	if attr_value[0] == 'href'
  		begin
	  		p attr_value[1]
	  		response = Net::HTTP.get_response(URI(attr_value[1]));
	  		p response.code
	  	rescue Exception => e  
	  		p e
	  	end
  	end
  end
end

# ajax solution
# 1.add "render partial: 'errors' if request.xhr?";
# 2.create '_errors.html.haml' to generate a error list table
# 

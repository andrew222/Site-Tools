# encoding: utf-8
require 'nokogiri'
require 'open-uri'
require 'uri'
require 'net/http'
require "html_spellchecker"
require 'ffi/hunspell'
require 'anemone'

class CheckLinksJob
  @queue = :check_links

  def self.perform
  	p 'check links'
  	page_url = 'http://www.ekohe.com'
  	page_host = URI(page_url).host
    doc = Nokogiri::HTML(open(page_url))
		# Search for nodes by css
		# Check whether links are broken or not
		links = []
		links = doc.css('a')
		imgs = doc.css('img')
		links.each do |link|
	  		begin
	  			link_url = link['href']
	  			link_type = type_of_link(link_url, page_host)
	  			p link_type
	  			unless link_url.match(/^\//).nil?
	  				link_url = page_url + link_url
	  			end
	  			p link_url
	  			link_uri = URI(link_url)
	  			if link_uri.scheme == 'http' || link_uri.scheme == 'https'
			  		response = Net::HTTP.get_response(link_uri)
		  			p response.code
			  	end
		  	rescue Exception => e  
		  		p e
		  	end
		end

		first_level_children = doc.css('body').children()
		first_level_children.each do |e|
			if e.node_name != 'javascript' 
				# translate string to Nokogiri documents
				checked_node = Nokogiri::HTML(check_spell(e.to_html()))
				error_elements = checked_node.css('span.misspelled')
				error_elements.each do |e|
					p '$$$$$$$$$$$$$$$error elements'
					p e.to_html
					p e.node_name
				end
			end
		end

  end

  def self.type_of_link(link, host)
  	if( link.match(/^http\:\/\/#{host}/).nil? && link.match(/^\//).nil? )
  		return 0
  	else
  		return 1
  	end
  end
  
  def self.check_spell(text)
  	return HTML_Spellchecker.english.spellcheck(text)
  end
end
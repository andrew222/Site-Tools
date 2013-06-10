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

  def self.perform(site_id)
  	site = Site.find(site_id)
  	page_url = site.url
    doc = Nokogiri::HTML(open(page_url))
		# # Search for nodes by css
		check_broken_links(doc, site)

		check_spelling_errors(doc, site)
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

  def self.check_broken_links(doc, site)
  	page_url = site.url
  	page_host = URI(page_url).host
  	# # Check whether links are broken or not
		links = doc.css('a')
		# # imgs = doc.css('img')
		links.each do |link|
	  		begin
	  			link_url = link['href']
	  			dom_elem = link.to_html()
	  			link_type = type_of_link(link_url, page_host)
	  			unless link_url.match(/^\//).nil?
	  				link_url = page_url + link_url
	  			end
	  			link_uri = URI(link_url)
	  			if link_uri.scheme == 'http' || link_uri.scheme == 'https'
			  		response = Net::HTTP.get_response(link_uri)
		  			@broken_link = site.broken_links.build(:dom_elem => dom_elem, :url => link_url, :status_code => response.code, :link_type => link_type)
	  				@broken_link.save!
			  	end
		  	rescue Exception => e  
		  		p e
		  	end
		end
  end

  def self.check_spelling_errors(doc, site)
			first_level_children = doc.css('body').children()

			# init a spell dictionary
			dict = FFI::Hunspell.dict('en_GB')

			first_level_children.each do |e|
				if e.node_name != 'javascript' 
					# translate string to Nokogiri documents
					checked_node = Nokogiri::HTML(check_spell(e.to_html()))
					error_elements = checked_node.css('span.misspelled')
					error_elements.each do |e|
						p e.text()
						error_word = e.text()
							unless dict.check?(error_word)
								suggestion_words = dict.suggest(error_word)
							end
						error = site.spelling_errors.new(:error_elem => e.parent(), :error_word => error_word, :suggestion_words => suggestion_words)
						error.save
					end
				end
			end
  end
end
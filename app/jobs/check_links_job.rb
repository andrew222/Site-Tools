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
    wait_for_request_again = check_broken_links(doc, site)

    wait_for_request_again.each do |link|
      doc = Nokogiri::HTML(open(link))
      check_broken_links(doc, site)
    end
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
    wait_for_request_again = []
  	page_url = site.url
  	page_host = URI(page_url).host
  	# # Check whether links are broken or not
    links = doc.css('a')
    # # imgs = doc.css('img')
    links.each do |link|
        link_url = link['href']
        dom_elem = link.to_html()
        link_type = type_of_link(link_url, page_host)
        unless link_url.match(/^\//).nil?
            link_url = page_url + link_url
        end
        link_uri = URI(link_url)
        if link_uri.scheme == 'http' || link_uri.scheme == 'https'
            begin
                response = Net::HTTP.get_response(link_uri)
                status_code = response.status
            rescue Exception => e 
                status_code = request_exception(e)
                p status_code
            end
        end
        if status_code == 408
          wait_for_request_again << link_url
        else
          save_broken_link(site, link_url, dom_elem, link_type, status_code)
        end
    end
    return wait_for_request_again
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

  def self.request_exception(exception)
		exp_str = exception.to_s
		if exp_str.match(/timed out/).nil?
			return 408
		end
  end

  def self.save_broken_link(site, link_url, dom_elem, link_type, res_code)
  	@broken_link = site.broken_links.where(:url => link_url, :dom_elem => dom_elem, :link_type => link_type)
    if @broken_link.length == 0
      @broken_link = site.broken_links.create(:dom_elem => dom_elem, :url => link_url, :status_code => res_code, :link_type => link_type)
    else
      @broken_link.update_all({status_code: res_code})
    end
  end
end

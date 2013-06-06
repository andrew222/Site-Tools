class Site
  require 'nokogiri'
	require 'open-uri'

  include Mongoid::Document
  field :url, type: String
  field :name, type: String

  belongs_to :user
  has_many :broken_links, dependent: :delete
  
  after_save :analyze_site
	cattr_accessor :current_user

  def analyze_site
  	# Get a Nokogiri::HTML::Document for the page we’re interested in...
  	@site = current_user.sites.first
		doc = Nokogiri::HTML(open(@site.url))
		# Search for nodes by css
		# Check whether links are broken or not
		doc.css('a').each do |link|
	  		begin
		  		p "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~link['href']"
		  		link_href = link['href']
		  		response = Net::HTTP.get_response(URI(link_href));
		  		@broken_link = @site.broken_links.build(:url => link_href, :status_code => response.code)
		  		@broken_link.save!
		  	rescue Exception => e  
		  		p e
		  	end
		end

  end
end

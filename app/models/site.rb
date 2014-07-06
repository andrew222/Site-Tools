class Site
  require 'nokogiri'
  require 'open-uri'

  include Mongoid::Document
  field :url, type: String
  field :name, type: String

  belongs_to :user
  has_many :broken_links, dependent: :delete
  has_many :spelling_errors, dependent: :delete
  
  cattr_accessor :current_user

end

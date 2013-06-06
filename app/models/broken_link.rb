class BrokenLink
  include Mongoid::Document
  field :url, type: String
  field :dom_elem, type: String
  field :link_type, type: Integer
  field :recommendation, type: String
  field :details, type: String
  field :status_code, type: Integer

  belongs_to :site
end

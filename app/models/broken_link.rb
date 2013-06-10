class BrokenLink
  include Mongoid::Document
  field :url, type: String
  field :dom_elem, type: String # <a href='http://domain.com'>text</a>
  field :link_type, type: Integer # 1=>internal, 0=>external
  field :recommendation, type: String
  field :details, type: String
  field :status_code, type: Integer # 200, 404 or 500

  belongs_to :site
end

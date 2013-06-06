# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :broken_link do
    url "MyText"
    dom_elem "MyText"
    link_type 1
    recommendation "MyText"
    details "MyText"
  end
end

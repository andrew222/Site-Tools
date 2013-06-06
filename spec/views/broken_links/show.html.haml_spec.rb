require 'spec_helper'

describe "broken_links/show" do
  before(:each) do
    @broken_link = assign(:broken_link, stub_model(BrokenLink,
      :url => "MyText",
      :dom_elem => "MyText",
      :link_type => 1,
      :recommendation => "MyText",
      :details => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end

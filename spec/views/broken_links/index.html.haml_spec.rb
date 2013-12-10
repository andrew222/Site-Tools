require 'spec_helper'

describe "broken_links/index" do
  before(:each) do
    assign(:broken_links, [
      stub_model(BrokenLink,
        :url => "MyText",
        :dom_elem => "MyText",
        :link_type => 1,
        :recommendation => "MyText",
        :details => "MyText"
      ),
      stub_model(BrokenLink,
        :url => "MyText",
        :dom_elem => "MyText",
        :link_type => 1,
        :recommendation => "MyText",
        :details => "MyText"
      )
    ])
  end

  it "renders a list of broken_links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end

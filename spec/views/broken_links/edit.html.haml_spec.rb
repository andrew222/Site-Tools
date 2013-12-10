require 'spec_helper'

describe "broken_links/edit" do
  before(:each) do
    @broken_link = assign(:broken_link, stub_model(BrokenLink,
      :url => "MyText",
      :dom_elem => "MyText",
      :link_type => 1,
      :recommendation => "MyText",
      :details => "MyText"
    ))
  end

  it "renders the edit broken_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => broken_links_path(@broken_link), :method => "post" do
      assert_select "textarea#broken_link_url", :name => "broken_link[url]"
      assert_select "textarea#broken_link_dom_elem", :name => "broken_link[dom_elem]"
      assert_select "input#broken_link_link_type", :name => "broken_link[link_type]"
      assert_select "textarea#broken_link_recommendation", :name => "broken_link[recommendation]"
      assert_select "textarea#broken_link_details", :name => "broken_link[details]"
    end
  end
end

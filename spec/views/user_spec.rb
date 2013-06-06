# spec/views/user.rb
require 'spec_helper'
describe User do
	it "signs me in" do
		@user = FactoryGirl.create(:user, :password => 'andrew')
    visit '/signin'
    fill_in 'user_name', :with => @user.name
    fill_in 'user_password', :with => @user.password
    click_button 'SignIn'
    page.should have_selector('Log Out')
  end
end
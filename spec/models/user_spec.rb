# spec/models/user.rb
require 'spec_helper'
describe User do
	it 'should be valid' do
		FactoryGirl.create(:user).should be_valid
	end
end
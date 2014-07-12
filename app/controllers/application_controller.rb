require 'will_paginate/array'
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
		user = User.find(session[:current_user_id]) unless session[:current_user_id].nil?
    unless user.nil?
      Site.current_user = user
    end
	end
	def login_required
    if session[:current_user_id]
      return true
    end

    flash[:warning]='Please login to continue'
    redirect_to :controller => "users", :action => "signin"
    return false 
  end
end

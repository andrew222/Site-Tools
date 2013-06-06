class UsersController < ApplicationController

	before_filter :login_required, :only => [:dashboard]

  def signup
  	if request.post?
	  	options = params[:user]
	  	@user = User.create({
	  		name: options[:name],
	  		password: options[:password],
	  		email: options[:email],
	  		password: options[:password]
	  		})
		  session[:current_user_id] = @user.id
		  redirect_to :action => "dashboard"
		end
  end

  def logout
  	session[:current_user_id] = nil
  	redirect_to :action => 'signin'
  end

  def signin
  	if request.post?
	  	options = params[:user]
	  	if session[:current_user_id] = User.authenticate(options[:name], options[:password])
	  		flash[:message] = 'Log in successful'
	  		redirect_to :action => 'dashboard'
	  	else
	  		flash[:warning] = "Login unsuccessful"
	  		redirect_to :action => 'signin'
	  	end
	  end
  end

  def dashboard
  end
end

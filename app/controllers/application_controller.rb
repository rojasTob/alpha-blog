class ApplicationController < ActionController::Base

  #This method will be available to the views and controllers. 
  helper_method :current_user
  def current_user
    #memoization here!!
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?
  def logged_in?
    #to return a boolean
    !!current_user
  end
end

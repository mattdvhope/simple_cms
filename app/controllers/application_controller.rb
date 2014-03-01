class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def confirm_logged_in # With this method in application_controller.rb, it is now available to ALL of the controllers since they inherit from here.
    unless session[:user_id]
      flash[:notice] = "Please log in"
      redirect_to(:controller => 'access', :action => 'login') # there is no action 'login' in subjects, pages or sections, therefore we must specify that the 'login' action is in the 'access' controller regardless of which of these other controllers is calling the before_action filter
      return false # halts the before_action; very important to have 'false' here!!
    else
      return true
    end
  end

end

class AccessController < ApplicationController

  layout 'admin'

  def index
    # displays text & links; no business to do here
  end

  def login
    # displays a login form; two empty fields: one for user_name and one for password
  end

  def attempt_login
    if params[:username].present? && params[:password].present? # .present? is a Rails method to check if something is not blank
      found_user = AdminUser.where(username: params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password]) # if a 'found_user' is found, it will return the 'found_user' to us again; we'll then assign that 'found_user' to the 'authorized_user' variable; if it's not found, then 'false' will be returned. Summary: either an object or 'false' will be returned. #authenticate(unencrypted_password) is a method given to us by ‘has_secure_password’ that we can use in our controller
      end
    end
    if authorized_user # the object returned above counts as being 'true' here
      # TODO: mark user as logged in
      flash[:notice] = "You are now logged in."
      redirect_to(action: 'index')
    else # we go to 'else' here if the 'found_user.authenticate(params[:password])' was not authenticated..if authorized_user is equal to 'false'
      flash[:notice] = "Invalid username/password combination."
      redirect_to(action: 'login')
    end
  end

  def logout
    # TODO: mark user as logged out
    flash[:notice] = "Logged out"
    redirect_to(action: "login")
  end

end

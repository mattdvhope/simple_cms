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
        authorized_user = found_user.authenticate(params[:password]) # if a 'found_user' is authenticated via his/her password, it will return the 'found_user' to us again; we'll then assign that 'found_user' to the 'authorized_user' variable; if it's not found, then 'false' will be returned. Summary: either an object or 'false' will be returned. #authenticate(unencrypted_password) is a method given to us by ‘has_secure_password’ that we can use to match the password with the corresponding encryption
      end
    end
    if authorized_user # the object returned above counts as being 'true' here
      # mark user as logged in
      session[:user_id] = authorized_user.id # we set this session id which goes in the user's 'super cookie' on the user's browser, & then with each request, they'll be sending us that session id again; if they're savvy, they'll be able to see their user_id in their cookie, but it wouldn't be modifiable b/c we have that hashed value that ensures that cookies can't be tampered with in config/initializers/secret_token.rb. On subsequent pages, we'll be able check for this user_id (like a hand-stamp) to make sure that they're authorized to view the pages; to make sure that they have previously authenticated themselves.

      session[:username] = authorized_user.username # Let's use this username for convenience so we don't always have to go back to the db to get their username again.
      flash[:notice] = "You are now logged in."
      redirect_to(action: 'index')
    else # we go to 'else' here if the 'found_user.authenticate(params[:password])' was not authenticated..if authorized_user is equal to 'false'
      flash[:notice] = "Invalid username/password combination."
      redirect_to(action: 'login')
    end
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(action: "login")
  end

end

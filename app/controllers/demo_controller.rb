class DemoController < ApplicationController

  layout 'application'

  def index
    render('index') #nothing to do with 'hello' action below; it's just the name of the template being used
  end

  def hello
    # render('index')
    @array = [1,2,3,4,5]
    @id = params['id'].to_i
    @page = params[:page].to_i
  end

  def other_hello
    # redirect_to(:controller => 'demo', :action => 'index')
    redirect_to(:action => 'index') #according to the routes.rb, when you have demo controller and the index action, it's the same thing as asking for the root of the site
  end

  def lynda
    redirect_to("http://lynda.com") #it doesn't have to be to a controller and a view; you can go to any URL that you want.
  end

  def text_helpers    
  end

  def escape_output
  end

  def make_error
    # My guesses for the 3 most common errors:
    # render(:text => "test" # syntax error
    # render(:text => @something.upcase) # undefined method
    render(:text => "1" + 1) # can't convert type
  end

  def logging # These are messages to the logger (../config/environments/development.rb).
    logger.debug("This is debug.")
    logger.info("This is info.")
    logger.warn("This is warn.") # If ../config/environments/development.rb has 'config.log_level = :warn' in it, in the rails console, we'll see 'This is warn.', 'This is error.', 'This is fatal.', but not 'This is debug.' or 'This is info.'.
    logger.error("This is error.")
    logger.fatal("This is fatal.")
    render(:text => 'Logged!')
  end

end

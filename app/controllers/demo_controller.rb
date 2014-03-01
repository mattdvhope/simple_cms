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

end

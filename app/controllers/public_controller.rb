class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation

  def index
  end

  def show
    @page = Page.where(:permalink => params[:permalink], :visible => true).first # the params[:permalink] is what is made available to me by that route; It's NOT the route, ':controller(/:action(/:id))'; it's :permalink.
    if @page.nil?                                                        # .first because we don't want to get an array; just want to get the first one that it finds
      redirect_to(action: 'index')
    else # if the page was in fact found
      # display the page content using show.html.erb
    end
  end

  private

  def setup_navigation
    @subjects = Subject.visible.sorted
# binding.pry
  end

end

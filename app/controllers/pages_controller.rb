class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject # with this, we always from the subject, so that now the Pages can be nested in the correct/corresponding subject

  def index # (Nesting Pages in Subjects) This index action knows what subject.id called it because in views/subjects/index.html.erb, when the link "View Pages" is clicked, subject_id = subject.id ;  it thus knows what subject.id called; it's very important to do this in views/subject/index.html.erb ; otherwise, this page won't know which subject called it and therefore will not be nested into that subject
    @pages = @subject.pages.sorted # We're using the relationship from subject to pages.
    # Or:  @pages = Page.where(:subject_id => @subject.id).sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Default"})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(action: 'index', subject_id: @subject.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page edited successfully."
      redirect_to(action: 'show', id: @page.id, subject_id: @subject.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully."
    redirect_to(action: 'index', subject_id: @subject.id)
  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
  end

  def find_subject # every action will call this method first thing; if it has subject_id sent, it will find that subject_id in the database and set @subject equal to it
    if params[:subject_id] # if the subject_id is sent (from views/subjects/index.html.erb when "View Pages" is clicked)
      @subject = Subject.find(params[:subject_id])
    end
  end

end

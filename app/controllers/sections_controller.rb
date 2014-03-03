class SectionsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_page

  def index
    @sections = @page.sections.sorted
    # Or:  @sections = Section.where(:page_id => @page.id).sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id, :name => "Default")
    # @pages = Page.order('position ASC')
    @pages = @page.subject.pages.sorted # I only want to see the pages within this same section; I don't want to move to all pages in any subject anywhere.
    @section_count = Section.count + 1
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section was successfully created."
      redirect_to(action: 'index', page_id: @page.id)
    else
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section was successfully updated."
      redirect_to(action: 'show', id: @section.id, page_id: @page.id)
    else
      @pages = Page.order('position ASC')
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' was successfully destroyed"
    redirect_to(action: 'index', page_id: @page.id)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_page # every action will call this method first thing; if it has page_id sent, it will find that page_id in the database and set @page equal to it
    if params[:page_id] # if the page_id is sent (from views/pages/index.html.erb when "View Sections" is clicked)
      @page = Page.find(params[:page_id])
    end
  end

end

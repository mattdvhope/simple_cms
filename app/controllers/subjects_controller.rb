class SubjectsController < ApplicationController

  layout "admin"

  def index
    # @subjects = Subject.all
    # @subjects = Subject.order("position ASC")
    @subjects = Subject.sorted #using the :sorted scope-method from the model in subject.rb
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"}) #this is not absolutely necessary, but it's considered best practice to always instantiate an object here; allows rails to use set default values; otherwise, the form values will be blank; with an object, you can also set new defaults
    @subject_count = Subject.count + 1 # we add one b/c whenever want to make a new subject, we are adding one additional subject
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(action: 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1 # we add one b/c whenever want to make a new subject, we are adding one additional subject
      render('new') #render the 'new.html.erb' template
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    # Find an existing object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "Subject updated successfully."
      redirect_to(action: 'show', id: @subject.id)
    else
      # If update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit') #render the 'new.html.erb' template
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(action: 'index')
  end

  private

  def subject_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

end
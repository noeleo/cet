class ProjectsController < ApplicationController

  before_filter :set_current_user
  before_filter :set_can_edit, :except => :new

  def new_or_edit
    # see if we are creating a new project or just editing an existing one
    if params[:pid]
      project = Project.find_by_id(params[:pid])
    else
      project = Project.new
      project.add_collaborator(@user)
      project.creator = @user
    end

    project_info = params[:project]
    project.title = project_info[:title]
    project.description = project_info[:description]
    project.school_id = @user.school

    success = project.save
    if success
      if params[:pid]
        flash[:notice] = "Project successfully edited!"
      else
        flash[:notice] = "Project successfully created!"
      end
      redirect_to project_path(project.id) and return
    end
    # if unsuccessful, flash an error
    if params[:pid]
      flash[:error] = "Sorry, something went wrong with editing this project."
      redirect_to edit_project_path(project.id)
    else
      flash[:error] = "Sorry, something went wrong with creating a new project."
      redirect_to new_project_path
    end
  end

  def new
    if params[:project]
      # process the form
      new_or_edit and return
    end
  end

  def edit
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end
    if params[:project]
      new_or_edit and return
    end
    @project = Project.find_by_id(params[:pid])
    @can_delete = false
    @can_delete = true if (@project.creator == @user or (@user.admin and @user.school_id == @project.school_id))
  end

  def show
    @project = Project.find_by_id(params[:pid])
    @comments = @project.comments.order("created_at DESC")
    @document = Document.new
  end

  def destroy
    @project = Project.find_by_id(params[:pid])
    # can only destroy if you are creator
    if @project.creator == @user
      if @project.destroy
        flash[:notice] = "Successfully deleted " + @project.title
        redirect_to school_path(@user.school.uri) and return
      else
        flash[:error] = "Oops, something went wrong with deleting " + @project.title
      end
    else
      flash[:error] = "You can't delete this project!"
    end
    redirect_to project_path(@project.id)
  end

  def edit_collaborators
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end
  end

  def add_collaborator
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end
    email = params[:collaborator]
    success = @project.add_collaborator_by_email(email)
    if success
      flash[:notice] = "Collaborator added!"
    else
      flash[:error] = "Invalid collaborator!"
    end
    redirect_to edit_collaborators_path
  end

  def destroy_collaborator
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end
    collaborator = User.find_by_id(params[:cid])
    if collaborator == @user or collaborator == @project.creator
      # You can't delete yourself or creator
      flash[:error] = "Oops, you can't do that!"
      redirect_to edit_collaborators_path(@project.id) and return
    end
    success = @project.users.delete(collaborator)
    if success
      flash[:notice] = "Collaborator deleted!"
    else
      flash[:error] = "Oops! Something went wrong."
    end
    redirect_to edit_collaborators_path(@project.id)
  end

end

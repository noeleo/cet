class SchoolsController < ApplicationController

  before_filter :set_current_user, :set_school

  def set_school
    redirect_to school_path(params[:school].downcase) and return if params[:school] != params[:school].downcase
    @school = School.find_by_uri(params[:school])
    redirect_to home_path and return if not @school
  end

  def index
    @schools = School.all
  end

  def show
    @projects = @school.projects.order("created_at DESC")
    @events = @school.events.sort_by &:startTime
  end

  def new
  end

  def edit
  end

  def destroy
  end

end

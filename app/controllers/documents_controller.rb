class DocumentsController < ApplicationController
  before_filter :set_current_user
  before_filter :set_can_edit

  def create
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end

    @document = Document.new(params[:document])
    @document.project = @project
    @document.updater = @user
    @project.documents << @document

    if @document.save
      flash[:notice] = "File added successfully"
      redirect_to project_path(@project.id)
    else
      flash[:error] = "There was a problem uploading your file"
      redirect_to project_path(@project.id)
    end
  end

  def destroy
    if not @can_edit
      flash[:error] = "Permission denied..."
      redirect_to project_path(@project.id) and return
    end
    doc = Document.find_by_id(params[:did])
    doc.avatar.destroy
    doc.destroy
    flash[:notice] = "File deleted successfully."
    redirect_to project_path(@project.id)
  end

end

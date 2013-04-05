class CommentsController < ApplicationController

  before_filter :set_current_user
  before_filter :set_can_edit

  def create
    # should just set the text field
    comment = Comment.new(params[:comment])
    comment.user = @user
    comment.project = @project
    if comment.save
      flash[:notice] = "Commented!"
    else
      flash[:error] = "Oops, something went wrong with creating your comment."
    end
    redirect_to project_path(@project.id)
  end

  def destroy
    comment = Comment.find_by_id(params[:comid])
    if @can_edit or @user.id == comment.user.id
      # can destroy only if you are collaborator or you created the comment
      flash[:notice] = "Comment deleted!" if comment.destroy
    else
      flash[:error] = "You can't delete this comment!"
    end
    redirect_to project_path(@project.id)
  end
end

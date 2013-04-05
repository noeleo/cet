class HomeController < ApplicationController

  def show
    # if you're logged in, you should be redirected to your school's homepage
    user = User.find_by_id(session[:user_id])
    if user
      redirect_to school_path(user.school.uri) and return
    end
  end

end

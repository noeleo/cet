class SessionsController < ApplicationController

  @@current_user

  def login
    # For now, use our custom login page.
    # In the future, this method can be used to redirect to an omniauth login page to allow students to authenticate through their school.
  end

  def create
    # This allows our custom login page to mimic the behavior of omniauth by creating a new auth_hash.
    # This code should be removed if the custom login page is removed from the application.
    unless (params[:login_hash]).nil?
      auth_hash[:uid] = params[:login_hash]['email']
      auth_hash[:info][:email] = params[:login_hash]['email']
      auth_hash[:info][:name] = params[:login_hash]['name']
    end

    if auth_hash and User.find_by_uid(auth_hash[:uid]).nil?
      # validate email format
      results = ValidatesEmailFormatOf::validate_email_format(auth_hash[:uid], :message => "is not of a valid format!")
      unless results.nil?
        flash[:error] = "Please use a valid email address!"
        redirect_to login_path and return
      end
      @is_new_user = true
      flash[:notice] = "Welcome new user! Please fill out your profile information."
    else
      @is_new_user = false
    end

    @user = User.find_or_create_from_auth_hash(auth_hash)
    @@current_user = @user
    session[:user_id] = @user.id
    if @is_new_user
      redirect_to edit_profile_path(@user.id)
    else
      redirect_to profile_path(@user.id)
    end
  end

  def failure
    render :text => "Sorry, but we didn't receive the permissions we need for your account."
  end

  def destroy
    @@current_user = nil
    session[:user_id] = nil
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end

class SessionsController < ApplicationController

  def new
  end

  def create
    unless valid_params?
      flash[:danger] = 'Invalid email/password combination'
      return redirect_to root_path
    end

    user = User.find_by(email: params[:session][:email].downcase)
    if user.nil? || user.authenticate(params[:session][:password])
      if user.nil?
        user = User.new(user_params)
        user.save!
        flash[:success] = 'You are registered and logged!'
      else
        flash[:success] = 'Login success!'
      end
      log_in user
    else
      flash[:danger] = 'Invalid email/password combination'
    end
    redirect_to root_path
  end

  def valid_params?
    params[:session][:email].present? && params[:session][:password].present?
  end

  def user_params
    params.require(:session).permit(:email, :password)
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
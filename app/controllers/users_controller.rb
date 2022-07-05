# frozen_string_literal: true

class UsersController < ActionController::Base
  def index
    @users = User.filter_by_query(query: params[:query])

    cookies[:comment_create_time] = Time.zone.now
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    @user.save ? redirect_to(action: :index) : render(:new, status: :unprocessable_entity)
  end

  def delete_all
    User.delete_all_by_query(query: params[:query])

    redirect_to action: :index
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :dob, :email, :password)
  end
end
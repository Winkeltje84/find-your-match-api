class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_admin?

  def index
    @users = User.all

  end

  def show
    render_user
  end

  def update
    switch_admin_student
  end

  def edit
    render_user
  end


private

  def user_is_admin?
    redirect_to :root, notice: "Pretty sure you're no admin..." unless current_user && current_user.admin?
  end

  def switch_admin_student
    render_user

    if (@user.admin === true)
      @user.update_attributes(admin: false)
    else
      @user.update_attributes(admin: true)
    end
    redirect_to admin_users_path, notice: "Changed the admin status"
  end

  def render_user
    @user = User.find(params[:id])
  end

end

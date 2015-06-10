class  Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :check_admin
  
  def index
    @users = User.paginate page: params[:page]
  end
  
  def show
    @user = User.find params[:id]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to admin_users_path
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes params_user
      flash[:success] = "Profile updated"
      redirect_to  admin_user_path(@user)
    else
      render :edit
    end
  end
  
  private
  def params_user
    params.require(:user).permit :name, :email, :password, :password_confirmation , :role
  end
end
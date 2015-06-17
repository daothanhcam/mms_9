class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :check_admin
  before_action :set_user, except: :index

  def index
    @users = User.paginate page: params[:page]
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes params_user
      flash[:success] = t "user.update"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = t "user.destroy"
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def params_user
    params.require(:user)
      .permit :name, :email, :password, :password_confirmation, :role
  end
end

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :check_admin
  before_action :set_user, except: [:index, :new, :create]

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.created"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.update"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.delete
    flash[:success] = t "user.destroy"
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :username, :email, :role, :password,
      :password_confirmation, :birthday,
      position_users_attributes: [:id, :user_id, :position_id, :_destroy]
  end
end

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :check_admin
  before_action :set_user, except: [:index, :new, :create]

  def index
    @search = User.search params[:q]
    @users = @search.result.paginate page: params[:page],
                                     per_page: Settings.size_per_page
  end

  def new
    @user = User.new
    @user.position_users.build
    @positions = Position.all
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
    @user = User.find params[:id]
    respond_to do |format|
      format.html
      format.csv {send_data @user.to_csv}
    end
  end

  def edit
    @positions = Position.all
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
    @user.destroy
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

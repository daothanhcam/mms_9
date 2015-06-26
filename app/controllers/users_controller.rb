class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      respond_to do |format|
        format.html {redirect_to user_skills_path @user}
        format.js
      end
    end
  end

  def edit
    @user = User.find params[:id]
    @skills = Skill.all
    @skills.each do |skill|
      skill.skill_users.build skill_id: skill.id
    end
  end

  private
  def user_params
    params.require(:user)
      .permit :name, :email, :password, :password_confirmation,
       skill_users_attributes: [:id, :skill_id, :level, :year, :_destroy], skill_ids:[]
  end
end

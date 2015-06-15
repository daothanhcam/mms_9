class Admin::TeamUsersController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def show
    @team = Team.find params[:team_id]
    @users = User.user_not_team
    @users_in_team = @team.users
  end
end

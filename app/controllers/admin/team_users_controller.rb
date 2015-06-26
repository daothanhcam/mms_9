class Admin::TeamUsersController < ApplicationController
  before_action :check_admin

  def show
    @team = Team.find params[:team_id]
    @users_in_team = @team.users
    @users = User.user_not_team + @users_in_team
  end
end

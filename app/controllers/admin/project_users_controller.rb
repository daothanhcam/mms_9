class Admin::ProjectUsersController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def show
    @project = Project.find params[:project_id]
    @in_project_users = @project.users
    @no_project_users = User.no_project + @project.users
  end
end

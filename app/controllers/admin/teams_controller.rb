class Admin::TeamsController < ApplicationController
  before_action :check_admin
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @search = Team.search params[:q]
    @teams = @search.result.paginate page: params[:page],
                                     per_page: Settings.size_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @teams.to_csv}
    end
  end

  def show
    @leader = @team.leader
    @users = @team.users
    @projects = @team.projects
  end

  def new
    @team = Team.new
    @leaders = User.user_not_team
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:notice] = t "team.created"
      redirect_to admin_team_members_path @team
    else
      render :new
    end
  end

  def edit
    @old_leader = User.where id: @team.leader_id
    @leaders = User.user_not_team + @old_leader
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t "team.update.success"
      respond_to do |format|
        format.html {redirect_to admin_team_path @team}
        format.js
      end
    else
      flash[:danger] = t "fail"
      redirect_to admin_teams_path
    end
  end

  def destroy
    @team.destroy
    flash[:success] = t "team.destroy"
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team)
      .permit :name, :description, :leader_id, user_ids: []
  end

  def set_team
    @team = Team.find params[:id]
  end
end

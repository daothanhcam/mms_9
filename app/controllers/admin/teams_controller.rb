class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def show
    @team = Team.find params[:id]
    @leader = User.find @team.leader_id
  end

  def new
    @team = Team.new
    @leaders = User.select_leader
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:notice] = t "team.created"
      redirect_to admin_team_members_path(@team)
    else
      render :new
    end
  end

  def edit
    @team = Team.find params[:id]
    @leaders = User.select_leader
  end

  def update
    @team = Team.find params[:id]
    if @team.update_attributes team_params
      flash[:success]= t "team.update.success"
      respond_to do |format|
        format.html {redirect_to admin_team_members_path(@team)}
        format.js
      end
    else
      flash[:danger] = t "fail"
      redirect_to admin_teams_path
    end
  end

  def index
    @teams = Team.paginate page: params[:page], per_page: Settings.size_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @teams.to_csv}
    end
  end

  def destroy
    @team = Team.find(params[:id]).destroy
    flash[:success] = t "team.destroy"
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team)
      .permit :name, :description, :leader_id, user_ids: []
  end
end

class Admin::TeamsController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def show
    @team = Team.find params[:id]
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_params
    if @team.save
      flash[:notice] = t "team.created"
      redirect_to admin_teams_path
    else
      render :new
    end
  end

  def edit
    @team = Team.find params[:id]
  end
  
  def update
    @team = Team.find params[:id]
    if @team.update_attributes team_params
      flash[:success]= t "team.update.success"
      redirect_to admin_teams_path
    else
      render :edit
      flash[:danger] = t "team.update.fail"
    end
  end

  def index
    @teams = Team.paginate page: params[:page], per_page: Settings.size_per_page
  end

  def destroy
    @team = Team.find(params[:id]).delete
    flash[:success] = t "team.destroy"
    redirect_to admin_teams_path
  end

  private
  def team_params
    params.require(:team).permit :name, :description
  end
end
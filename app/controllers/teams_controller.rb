class TeamsController < ApplicationController
  def index
    @search = Team.search params[:q]
    @teams = @search.result.paginate page: params[:page],
                                     per_page: Settings.size_per_page
  end

  def show
    @team = Team.find params[:id]
    @leader = @team.leader
    @users = @team.users.paginate page: params[:page],
                                  per_page: Settings.size_per_page
  end
end

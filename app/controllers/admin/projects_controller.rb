class Admin::ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.paginate page: params[:page],
                                 per_page: Settings.size_per_page
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = t "project.created"
      redirect_to admin_project_members_path(@project)
    else
      render :new
    end
  end

  def update
    if @project.update_attributes project_params
      flash[:success] = t "project.updated"
      redirect_to admin_project_members_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = t "project.destroy"
    redirect_to admin_projects_path
  end

  private
  def set_project
    @project = Project.find params[:id]
  end

  def project_params
    params.require(:project).permit :name, :abbreviation, :team_id,
      user_ids: []
  end
end

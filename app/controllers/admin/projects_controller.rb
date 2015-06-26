class Admin::ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def show
    @users = @project.users
  end

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
      redirect_to admin_project_members_path @project
    else
      render :new
    end
  end

  def update
    if @project.update_attributes project_params
      flash[:success] = t "project.updated"
      redirect_to admin_project_path @project
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = t "project.destroy"
    else
      flash[:success] = t "project.destroy_fail"
    end
    redirect_to admin_projects_path
  end

  private
  def set_project
    @project = Project.find params[:id]
  end

  def project_params
    params.require(:project).permit :name, :abbreviation, :project_id,
      user_ids: []
  end
end

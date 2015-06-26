class Admin::SkillsController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "skill.add"
      redirect_to admin_skills_path
    else
      render :new
    end
  end

  def edit
    @skill = Skill.find params[:id]
  end

  def update
    @skill = Skill.find params[:id]
    if @skill.update_attributes skill_params
      flash[:success] = t "skill.updated"
      redirect_to admin_skills_path
    else
      render :edit
    end
  end

  def destroy
    @skill = Skill.find params[:id]
    if @skill.destroy
      flash[:success] = t "skill.deleted"
    else
      flash[:danger] = t "skill.fail"
    end
    redirect_to admin_skills_path
  end

  def index
    @search = Skill.search params[:q]
    @skills = @search.result.paginate page: params[:page],
                                      per_page: Settings.size_per_page
    respond_to do |format|
      format.html
      format.csv {send_data @skills.to_csv}
    end
  end

  private
  def skill_params
    params.require(:skill).permit :name
  end
end

class Admin::SkillsController < ApplicationController
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t("skill.add")
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
      flash[:success] = t("skill.updated")
      redirect_to admin_skills_path
    else
      render :edit
    end
  end

  def index
    @skills = Skill.paginate page: params[:page], per_page: Settings.size_per_page
  end

  def skill_params
    params.require(:skill).permit :name
  end
end

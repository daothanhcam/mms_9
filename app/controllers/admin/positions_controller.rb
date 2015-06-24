class Admin::PositionsController < ApplicationController
  before_action :set_position, except: [:index, :new, :create]

  def index
    @positions = Position.paginate page: params[:page],
                                   per_page: Settings.size_per_page
    respond_to do |format|
      format.html
      format.csv{send_data @positions.to_csv}
    end
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t "position.created"
      redirect_to admin_positions_path
    else
      render :new
    end
  end

  def update
    if @position.update_attributes position_params
      flash[:success] = t "position.updated"
      redirect_to admin_positions_path
    else
      render :edit
    end
  end

  def destroy
    @position.delete
    flash[:success] = t "position.destroy"
    redirect_to admin_positions_path
  end

  private
  def set_position
    @position = Position.find params[:id]
  end

  def position_params
    params.require(:position).permit :name, :abbreviation
  end
end

class Admin::ImportsController < ApplicationController
  skip_load_and_authorize_resource

  def create
    import_csv params[:model].safe_constantize, params[:file]
    redirect_to :back, notice: t("import.success")
  end

  private
  def import_csv model, file
    CSV.foreach(file.path, headers: true) do |row|
      f = model.find_by(id: row["id"]) || model.new
      f.attributes = row.to_hash.slice *row.to_hash.keys
      f.save!
    end
  end
end

module Logs
  def log_create
    ActivityLog.create!(time: Time.now, action: "#{model_name}", user: :Admin, description: "Create")
  end

  def log_update
    ActivityLog.create!(time: Time.now, action: "#{model_name}", user: :Admin, description: "Update")
  end

  def log_destroy
    ActivityLog.create!(time: Time.now, action: "#{model_name}", user: :Admin, description: "Destroy")
  end
end


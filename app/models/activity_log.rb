class ActivityLog < ActiveRecord::Base
  def self.remove_old_log
    ActivityLog.all.each do |log|
      log.destroy if (log.created_at + Settings.log.twoday.days) < Time.now
    end
  end
end

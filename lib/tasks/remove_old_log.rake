desc "remove old log"
task remove_old_log: :environment do
  ActivityLog.remove_old_log
end

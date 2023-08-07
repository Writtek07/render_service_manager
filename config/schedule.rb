# Check current runners: whenever
# Clear crontab: crontab -r
# Add to crontab: whenever --update-crontab
# Add to crontab: whenever --update-crontab --set environment='development'
# List all crontabs scheduled in system: crontab -l
# The above should run always when schedule is updated
# Path is needed else output comes as bundle command not found
env :PATH, ENV['PATH']
current_time = Time.now
set :output, "./log/cron_#{current_time.to_s}.log"
set :environment, 'development'
set :user, 'root'

# Content will be added after these from services model

every :day, at: '17:57' do
  rake 'services_1:start'
  runner "puts '================== End of start service call for Daily Fee created sms job at #{current_time} ================='"
end

every :day, at: '18:03' do
  rake 'services_1:stop'
  runner "puts '================== End of stop service call for Daily Fee created sms job at #{current_time} ================='"
end


every :day, at: '17:58' do
  rake 'services_2:start'
  runner "puts '================== End of start service call for sidekiq-worker at #{current_time}================='"
end

every :day, at: '18:10' do
  rake 'services_2:stop'
  runner "puts '================== End of stop service call for sidekiq-worker at #{current_time} ================='"
end


every :day, at: '16:57' do
  rake 'services_3:start'
  runner "puts '================== End of start service call for Daily sms service to admin at #{current_time} ================='"
end

every :day, at: '17:03' do
  rake 'services_3:stop'
  runner "puts '================== End of stop service call for Daily sms service to admin at #{current_time} ================='"
end


every :day, at: '09:20' do
  rake 'services_4:start'
  runner "puts '================== End of start service call for mimis_invoice at #{current_time} ================='"
end

every :day, at: '17:30' do
  rake 'services_4:stop'
  runner "puts '================== End of stop service call for mimis_invoice at #{current_time} ================='"
end

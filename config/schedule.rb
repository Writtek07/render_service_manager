# Check current runners: whenever
# Clear crontab: crontab -r
# Add to crontab: whenever --update-crontab
# Add to crontab: whenever --update-crontab --set environment='development'
# List all crontabs scheduled in system: crontab -l
# The above should run always when schedule is updated
# Path is needed else output comes as bundle command not found
env :PATH, ENV['PATH']
name = Time.now
set :output, "./log/cron_#{name}.log"

every :day, at: '17:57' do
  rake 'services_1:start'
end

every :day, at: '18:03' do
  rake 'services_1:stop'
end


every :day, at: '17:57' do
  rake 'services_2:start'
end

every :day, at: '19:00' do
  rake 'services_2:stop'
end


every :day, at: '16:57' do
  rake 'services_3:start'
end

every :day, at: '17:03' do
  rake 'services_3:stop'
end


every :day, at: '09:00' do
  rake 'services_4:start'
end

every :day, at: '17:30' do
  rake 'services_4:stop'
end

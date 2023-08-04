# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

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


every 1.day, at: '2023-08-03 04:00:00 UTC' do
  rake 'services_26:start'
end

every 1.day, at: '2023-08-03 12:00:00 UTC' do
  rake 'services_26:stop'
end


every 1.day, at: '2023-08-03 11:15:00 UTC' do
  rake 'services_27:start'
end

every 1.day, at: '2023-08-03 11:45:00 UTC' do
  rake 'services_27:stop'
end


every 1.day, at: '2023-08-03 04:00:00 UTC' do
  rake 'services_28:start'
end

every 1.day, at: '2023-08-03 12:00:00 UTC' do
  rake 'services_28:stop'
end

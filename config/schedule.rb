require_relative '../config/environment'
# Check current runners: whenever
# Clear crontab: crontab -r
# Add to crontab: whenever --update-crontab
# Add to crontab: whenever --update-crontab --set environment='development'
# List all crontabs scheduled in system: crontab -l
# The above should run always when schedule is updated
# Path is needed else output comes as bundle command not found
ENV.each_key do |key|
  env key.to_sym, ENV[key]
end
current_time = Time.now
set :output, "./log/cron_#{current_time.to_s}.log"
set :environment, (Rails.env.production? ? ENV["RAILS_ENV"] : 'development')

# Content will be added after these from services model
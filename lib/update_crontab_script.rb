require_relative '../config/environment'
system('crontab -r')
Rails.env.production? ? system("whenever --update-crontab --set environment='production'") : system("whenever --update-crontab --set environment='development'")
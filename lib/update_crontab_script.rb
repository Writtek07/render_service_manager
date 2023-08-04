system('crontab -r')
system("whenever --update-crontab --set environment='development'")

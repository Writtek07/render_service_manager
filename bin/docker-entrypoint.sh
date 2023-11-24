#!/bin/bash

# If running the rails server then create or migrate existing database
if [ "${*}" == "./bin/rails server" ]; then
  ./bin/rails db:create
  ./bin/rails db:prepare
  ./bin/rails db:migrate
fi

cron && bundle exec whenever --set 'environment=production' --update-crontab

exec "${@}"

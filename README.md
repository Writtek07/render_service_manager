# ABOUT
* This is a Render service management system which fetches all your services hosted on [render](http://www.render.com/) and gives you the flexiblity to schedule the start and suspend of indiviual jobs using cron jobs in your local system. 
* Start the rails server once, schedule the jobs, update the crontabs and done. Close your rails app and relax, all your services will start and stop when scheduled to. This saves a lot of money as every other service on render is billed based on hours of usage.
* This entire setup will be done locally for security purposes, still, we will think of a way to make this secure on cloud in future releases.


# System dependencies 
### Ruby version - `3.2.1`
### Node version - `v18.15.0`
### Rails version - `7.0.6`
### Database - `postgresql`
### ENV Variables - Store in credentials.yml.enc or .env file in root, these are needed to bring up the service
* `RENDER_API_KEY`
* `DEFAULT_START_TIME`
* `DEFAULT_STOP_TIME`

# Configuration
* Clone the repo - `git clone git@github.com:Writtek07/render_service_manager.git`
* Setup database and migration -`rails db:setup & rails db:migrate`
* Start the server using - `bin/rails s` for development purpose
* The output is stored in `log/cron_date` file in the directory
* Keep the server always running by: `rails s -p 3030` command and use `localhost:3030` on browser for the tool.
* To stop the server: `ps aux| grep puma`, then kill the process id using `sudo kill -9 <pid>`

# Service now deployed on AWS.

# Points to Remember
* Server needs to keep running or cron tabs will throw error unable to connect to postgresql service.
* Device being used can be kept in `lock screen` mode but not power off.(Tested on windows)
* When you remove the db or migrate or reset the app to initial state or want to set it for a new client, remember to remove the lines added in `lib/services_cron_task.rake` and `config/schedule.rb`
* Check current set cron jobs by running `whenever` or `crontab -l` to list all currently added cron jobs to your system.
* Dont forget to click `Update Crontab` button after all scheduling is done or crontabs wont be added to system and hence wont run at   scheduled times.
* Curently all pushes, to remove the lines as suggested above, as the database will maintain the data client wise. 

# References
* https://www.rubyguides.com/2019/04/ruby-whenever-gem/
* https://www.youtube.com/watch?v=JOCGWYGiZns&t=2s
* https://api-docs.render.com/reference/introduction
class ServicesController < ApplicationController
  before_action :fetch_services

  def index
    @render_config = YAML.load_file(Rails.root.join('config', 'render_config.yml'))
  end
  
  def update_schedule
    @render_config = {
      'start_time' => params[:start_time],
      'stop_time' => params[:stop_time]
    }

    service_params = params[:services]
    service_params.each do |service_id, schedule|
      service = Service.find_or_initialize_by(id: service_id)
      service.name = schedule[:name]  # You can add name to the form fields in the view.
      service.service_id = schedule[:service_id]  # You can add service_id to the form fields in the view.
      service.custom_start_time = Time.zone.parse(schedule[:custom_start_time])
      service.custom_stop_time = Time.zone.parse(schedule[:custom_stop_time])      
      # update_schedule_file_on_save(service.id, schedule[:custom_start_time], schedule[:custom_stop_time])
      if service.schedule_removed?
        service.update_schedule_file_for_service
        update_schedule_file_on_save(service.id, service.custom_start_time, service.custom_stop_time)
      else
        update_schedule_file_on_save(service.id, service.custom_start_time, service.custom_stop_time)
      end
      service.schedule_removed = false
      service.save
    end
    
    redirect_to root_path, notice: 'Schedule updated successfully.'
  end

  def start_service
    service_id = params[:id]
    service = Service.find_by(service_id: service_id)
    RenderService.start_service(service_id)
    redirect_to root_path
    flash[:notice] = "Service #{service.name} started successfully."
  end

  def stop_service
    service_id = params[:id]
    service = Service.find_by(service_id: service_id)
    RenderService.stop_service(service_id)
    redirect_to root_path 
    flash[:error] = "Service #{service.name} stopped successfully."
  end

  def remove_schedule
    service_to_remove = Service.find_by(service_id: params[:id])
    remove_schedule_from_file(service_to_remove)
    service_to_remove.update(schedule_removed: true)
    redirect_to root_path 
    flash[:error] = "Service #{service_to_remove.name} has been removed from schedule."
  end


  def update_crontab
    # Assuming you have appropriate security measures here (e.g., check for admin/user roles).
    # This action should only be accessible to authorized users.

    # Execute the script using system command.    
    script_path = Rails.root.join('lib', 'update_crontab_script.rb')
    system("ruby #{script_path}")

    redirect_to root_path, notice: 'Crontab updated successfully'
  end

  private
  def fetch_services
    @services = []
    render_services = RenderService.list_services

    render_services.each do |render_service|
      service = Service.find_or_initialize_by(service_id: render_service['service']['id'])
      service.name = render_service['service']['name']
      if render_service['service']['suspended'] == 'suspended'
        service.status = 1
      else
        service.status = 0
      end
      service.custom_start_time ||= ENV['DEFAULT_START_TIME'] # Set default start time if not present
      service.custom_stop_time ||= ENV['DEFAULT_STOP_TIME']  # Set default stop time if not present
      service.save

      @services << service
    end
  end

  def update_schedule_file_on_save(id, custom_start_time, custom_stop_time)
    schedule_rb_path = Rails.root.join('config', 'schedule.rb')
    schedule_content = File.read(schedule_rb_path)

    # Update the custom start and stop times for the service in the schedule.rb file
    schedule_content.gsub!(/(every :day, at: ')(.*)(' do\s+rake 'services_#{id}:start')/, "\\1#{custom_start_time.strftime("%R")}\\3")
    schedule_content.gsub!(/(every :day, at: ')(.*)(' do\s+rake 'services_#{id}:stop')/, "\\1#{custom_stop_time.strftime("%R")}\\3")

    # remove extra spaces added
    schedule_content.gsub!(/^\s*\n(\s*\n)+/, "\n")
    # Write the updated contents back to the schedule.rb file
    File.write(schedule_rb_path, schedule_content)
  end

  def remove_schedule_from_file(service)
    schedule_rb_path = Rails.root.join('config', 'schedule.rb')
    schedule_content = File.read(schedule_rb_path)    
    
    start_pattern = <<-PATTERN.gsub(/^\s+/, '').strip
    every :day, at: '#{service.custom_start_time.strftime("%H:%M")}' do\n(.*?)\nend\n\n
    PATTERN
    stop_pattern = <<-PATTERN.gsub(/^\s+/, '').strip
    every :day, at: '#{service.custom_stop_time.strftime("%H:%M")}' do\n(.*?)\nend\n\n
    PATTERN

  # Remove the start schedule block for the given service_id
    schedule_content.sub!(Regexp.new(start_pattern, Regexp::MULTILINE), '')

  # Remove the stop schedule block for the given service_id
    schedule_content.sub!(Regexp.new(stop_pattern, Regexp::MULTILINE), '')

    # remove extra spaces
    schedule_content.gsub!(/^\s*\n(\s*\n)+/, "\n")
    # Write the updated contents back to the schedule.rb file
    File.write(schedule_rb_path, schedule_content)
  end
end

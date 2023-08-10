class Service < ApplicationRecord
    after_create :update_schedule_file_for_service, :create_rake_task
    # after_save :update_schedule_file_on_save, if: :custom_start_time_changed? || :custom_stop_time_changed?


    enum status: { active: 0, suspended: 1 }

    def update_schedule_file_for_service
      schedule_rb_path = Rails.root.join('config', 'schedule.rb')
      schedule_content = File.read(schedule_rb_path)
  
      # Get the highest service_id used in the schedule.rb file
      # max_service_id = schedule_content.scan(/\[start_time_(\d+)\]/).flatten.map(&:to_i).max || 0
  
      # Generate new lines for the new service and append them to the schedule_content
      new_lines = ""
      new_lines << "\n" unless schedule_content.end_with?("\n\n") || schedule_content.empty?
      new_lines << "every :day, at: '#{custom_start_time.strftime("%H:%M")}' do\n"        
      new_lines << "  rake 'services_#{id}:start'\n"
      new_lines << "  runner \"puts '================== End of start service call for service:#{name} ================='\"\n"
      new_lines << "end\n"
      new_lines << "\n"
      new_lines << "every :day, at: '#{custom_stop_time.strftime("%H:%M")}' do\n"        
      new_lines << "  rake 'services_#{id}:stop'\n"
      new_lines << "  runner \"puts '================== End of stop service call for service:#{name} ================='\"\n"
      new_lines << "end\n"
  
      schedule_content << new_lines        
      # Write the updated contents back to the schedule.rb file
      File.write(schedule_rb_path, schedule_content)
    end
    
    private
    

    def create_rake_task
        # Generate the content for the new rake task
        rake_task_content = <<~RAKE_TASK
          namespace :services_#{id} do
            desc 'Start the services'
            task start: :environment do
              service = Service.find_by(id: #{id})
              RenderService.start_service(service.service_id) if service
            end
          end
    
          namespace :services_#{id} do
            desc 'Stop the services'
            task stop: :environment do
              service = Service.find_by(id: #{id})
              RenderService.stop_service(service.service_id) if service
            end
          end
        RAKE_TASK
    
        # Append the new rake task content to the services_cron_task.rake file
        rake_task_file = Rails.root.join('lib', 'tasks', 'services_cron_task.rake')
        File.open(rake_task_file, 'a') { |f| f.puts rake_task_content }
    end
    
end

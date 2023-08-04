namespace :services_26 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 26)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_26 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 26)
    RenderService.stop_service(service.service_id) if service
  end
end
namespace :services_27 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 27)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_27 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 27)
    RenderService.stop_service(service.service_id) if service
  end
end
namespace :services_28 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 28)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_28 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 28)
    RenderService.stop_service(service.service_id) if service
  end
end

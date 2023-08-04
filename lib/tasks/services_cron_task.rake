namespace :services_1 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 1)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_1 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 1)
    RenderService.stop_service(service.service_id) if service
  end
end
namespace :services_2 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 2)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_2 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 2)
    RenderService.stop_service(service.service_id) if service
  end
end
namespace :services_3 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 3)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_3 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 3)
    RenderService.stop_service(service.service_id) if service
  end
end
namespace :services_4 do
  desc 'Start the services'
  task start: :environment do
    service = Service.find_by(id: 4)
    RenderService.start_service(service.service_id) if service
  end
end

namespace :services_4 do
  desc 'Stop the services'
  task stop: :environment do
    service = Service.find_by(id: 4)
    RenderService.stop_service(service.service_id) if service
  end
end

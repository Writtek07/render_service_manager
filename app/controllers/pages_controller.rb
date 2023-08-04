class PagesController < ApplicationController
  def index
    @services = RenderService.list_services
  end

  def start_service
    service_id = params[:id]
    RenderService.start_service(service_id)
    redirect_to root_path
    flash[:notice] = "Service #{service_id} started successfully."
  end

  def stop_service
    service_id = params[:id]
    RenderService.stop_service(service_id)
    redirect_to root_path
    flash[:error] = "Service #{service_id} stopped successfully."
  end
end

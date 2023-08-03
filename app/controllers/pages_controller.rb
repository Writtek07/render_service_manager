class PagesController < ApplicationController
  def index
    @services = RenderService.list_services
  end
end

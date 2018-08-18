class Creator::DashboardController < Creator::BaseController
  def index
    @videos = current_user.company.videos
  end
end
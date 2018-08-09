class Creator::DashboardController < Creator::BaseController
  def index
    @listings = current_user.company.listings
  end
end
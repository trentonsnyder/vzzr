class HomeController < AuthorizedController
  def index
    if current_user.company.creator?
      redirect_to creator_dashboard_path
    else
      redirect_to publisher_dashboard_path
    end
  end
end
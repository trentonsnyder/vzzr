class Publisher::BaseController < AuthorizedController
  before_action :assure_publisher

  protected

  def assure_publisher
    return if current_user.company.publisher?
    raise ActionController::RoutingError.new('Not Found')
  end
end
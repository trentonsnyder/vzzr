class Creator::BaseController < AuthorizedController
  before_action :assure_creator

  protected

  def assure_creator
    return if current_user.company.creator?
    raise ActionController::RoutingError.new('Not Found')
  end
end
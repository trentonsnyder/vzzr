class Publisher::BazaarController < Publisher::BaseController
  def browse
    @creators = Company.where(kind: 'creator')
  end
end
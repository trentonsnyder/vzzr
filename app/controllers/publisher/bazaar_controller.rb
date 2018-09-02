class Publisher::BazaarController < Publisher::BaseController
  def browse
    @creators = Company.where(kind: 'creator').limit(6)
    @creators2 = Company.where(kind: 'creator').order('id DESC').limit(4)
  end
end
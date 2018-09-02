class Creator::BazaarController < Creator::BaseController
  def browse
    @publishers = Company.where(kind: 'publisher').limit(6)
    @publishers2 = Company.where(kind: 'publisher').order('id DESC').limit(4)
  end
end
class Creator::BazaarController < Creator::BaseController
  def browse
    @publishers = Company.where(kind: 'publisher')
  end
end
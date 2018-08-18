class Publisher::CreatorsController < Publisher::BaseController
  def show
    @creator = Company.where(kind: 'creator').all.find(params[:id])
    @listings = @creator.listings
  end
end
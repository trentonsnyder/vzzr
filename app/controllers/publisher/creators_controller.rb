class Publisher::CreatorsController < Publisher::BaseController
  def show
    @creator = Company.where(kind: 'creator').all.find(params[:id])
    @videos = @creator.videos
  end
end
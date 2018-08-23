class Creator::PublishersController < Creator::BaseController
  def show
    @publisher = Company.where(kind: 'publisher').find(params[:id])
    @videos = Video.all.first ? [Video.first] : []
  end
end
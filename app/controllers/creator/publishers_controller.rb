class Creator::PublishersController < Creator::BaseController
  def show
    @publisher = Company.where(kind: 'publisher').find(params[:id])
    @videos = Video.all.first ? [Video.all.limit(4), Video.all ].flatten : []
  end
end
class Publisher::VideosController < Publisher::BaseController
  def show
    @video = Video.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
end

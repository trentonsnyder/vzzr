class Publisher::ListingsController < Publisher::BaseController
  def show
    @listing = Listing.find(params[:id])
    @video = @listing.videos.first
    respond_to do |format|
      format.js
    end
  end
end

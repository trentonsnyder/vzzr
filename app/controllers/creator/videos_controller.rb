class Creator::VideosController < Creator::BaseController
  before_action :set_listing

  def new
    set_s3_direct_post(@listing)
    @video = @listing.videos.new()
    respond_to do |format|
      format.js
    end
  end

  def create
    set_s3_direct_post(@listing)
    @video = @listing.videos.new(video_params)
    if @video.save
      redirect_to creator_dashboard_path
    else
      render :new
    end
  end

  protected

  def set_listing
    @listing = current_user.company.listings.find(params[:listing_id])
  end

  def video_params
    params.require(:video).permit(:thumbnail, :url, :listing_id)
  end

  def set_s3_direct_post(listing)
    bucket = Aws::S3::Bucket.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'us-west-2',
      name: ENV['S3_BUCKET']
    )
    @s3_direct_post = bucket.presigned_post(key: "uploads/#{listing.company_id}/videos/#{listing.id}/#{SecureRandom.uuid}${filename}", success_action_status: '201', acl: 'public-read')
  end
end

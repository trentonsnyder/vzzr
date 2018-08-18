class Creator::VideosController < Creator::BaseController
  def index
    @videos = current_user.company.videos
  end

  def new
    set_s3_direct_post(@video)
    @video = current_user.company.videos.new()
    respond_to do |format|
      format.js
    end
  end

  def create
    set_s3_direct_post(@video)
    @video = current_user.company.videos.new(video_params)
    if @video.save
      redirect_to creator_dashboard_path
    else
      render :new
    end
  end

  protected

  def video_params
    params.require(:video).permit(:name, :url, :description, :thumbnail, :genre_id)
  end

  def set_s3_direct_post(company_id)
    bucket = Aws::S3::Bucket.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'us-west-2',
      name: ENV['S3_BUCKET']
    )
    @s3_direct_post = bucket.presigned_post(key: "uploads/#{company_id}/videos/#{SecureRandom.uuid}${filename}", success_action_status: '201', acl: 'public-read')
  end
end

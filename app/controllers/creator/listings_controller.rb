class Creator::ListingsController < Creator::BaseController
  def index
    @listings = current_user.company.listings
  end

  def show
    @listing = current_user.company.listings.find(params[:id])
  end

  def new
    set_s3_direct_post(current_user.company.id)
    @listing = current_user.company.listings.new()
    respond_to do |format|
      format.js
    end
  end

  def create
    set_s3_direct_post(current_user.company.id)
    @listing = current_user.company.listings.new(listing_params)
    if @listing.save
      redirect_to new_creator_listing_video_url(@listing, format: :js)
    else
      render :new
    end
  end

  def edit
    @listing = current_user.company.listings.find(params[:id])
  end

  def update
    @listing = current_user.company.listings.find(params[:id])
    @listing.update(listing_params)
    if @listing.save
      redirect_to creator_listings_url
    else
      render :new
    end
  end

  def destroy
    @listing = current_user.company.find(params[:id])
    @listing.destroy
    redirect_to creator_listings_url
  end

  protected

  def listing_params
    params.require(:listing).permit(:name, :description, :thumbnail, :genre_id)
  end

  def set_s3_direct_post(company_id)
    bucket = Aws::S3::Bucket.new(
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'us-west-2',
      name: ENV['S3_BUCKET']
    )
    @s3_direct_post = bucket.presigned_post(key: "uploads/#{company_id}/listings/#{SecureRandom.uuid}${filename}", success_action_status: '201', acl: 'public-read')
  end
end
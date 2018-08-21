class Creator::DashboardController < Creator::BaseController
  def index
    @videos = current_user.company.videos.includes(:genre)
    @viewership = [
      { created_at: 1.hour.ago.beginning_of_hour.strftime("%H:%M"), views: 566 },
      { created_at: 2.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 400 },
      { created_at: 3.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 303 },
      { created_at: 4.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 353 },
      { created_at: 5.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 210 },
      { created_at: 6.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 308 }
    ]
    @publishers = Company.where(kind: "publisher")
  end
end
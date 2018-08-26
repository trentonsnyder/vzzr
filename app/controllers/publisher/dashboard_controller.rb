class Publisher::DashboardController < Publisher::BaseController
  def index
    @videos = Video.all.limit(5).includes(:genre)
    @viewership = [
      { created_at: 1.hour.ago.beginning_of_hour.strftime("%H:%M"), views: 288 },
      { created_at: 2.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 401 },
      { created_at: 3.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 303 },
      { created_at: 4.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 853 },
      { created_at: 5.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 1010 },
      { created_at: 6.hours.ago.beginning_of_hour.strftime("%H:%M"), views: 908 }
    ]
    @publishers = Company.where(kind: "creator")
  end
end
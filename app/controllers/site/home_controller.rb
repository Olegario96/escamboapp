class Site::HomeController < SiteController
  def index
    cookies[:user_name] = 'david'
    cookies[:lat_lon] = JSON.generate([47.5, 3])
    cookies[:login] = { value: 'XJ-122', expires: 1.hour.from_now }
    cookies.signed[:user_id] = 'Gustav Olegário'
    cookies.encrypted[:discount] = 45

    @categories = Category.order_by_description
    @ads = Ad.descending_order(params[:page])
    @carousel = Ad.random_carousel(3)
  end
end

class Site::SearchController < SiteController
  def ads
    cookies[:search] = params[:q]
    @ads = Ad.search(cookies[:search], params[:page])
    @categories = Category.all
  end
end

class Site::SearchController < SiteController
  def ads
    cookies[:search] = params[:q]
    @ads = Ad.search(cookies[:search], fields: [:title], page: params[:page], per_page: Ad::AMOUNT_PER_PAGE)
    @categories = Category.all
  end
end

class Backoffice::DashboardController < BackofficeController
  def index
    @categories_groups = Category.all.map {|c| [c.description, c.ads_count]}
  end
end

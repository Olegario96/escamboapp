class Site::Profile::AdsController < Site::ProfileController
  def index
    @ads = Ad.ads_for_current_member(current_member)
  end
end

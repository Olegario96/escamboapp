class Members::SessionsController < Devise::SessionsController
  def new
    super do |resource|
        resource.build_profile_member
    end
  end

  protected
    def after_sign_in_path_for(resource)
      last_location = stored_location_for(resource)

      if last_location.match(site_ad_detail_index_path)
        last_location
      else
        site_profile_dashboard_index_path
      end
    end
end

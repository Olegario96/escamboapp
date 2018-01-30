module Backoffice::AdminsHelper
  RoleOption = Struct.new(:index, :description)

  def options_for_role
    Admin.roles_i18n.map do |key, value|
      RoleOption.new(key, value)
    end
  end
end

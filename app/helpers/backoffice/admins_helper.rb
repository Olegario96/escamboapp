module Backoffice::AdminsHelper
  RoleOption = Struct.new(:index, :description)

  def options_for_role
    Role::ROLES.map do |key, value|
      RoleOption.new(key, value)
    end
  end
end

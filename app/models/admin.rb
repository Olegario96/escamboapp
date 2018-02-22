class Admin < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # ROLES = {:full_access => 0, :restricted_access => 1}

  # enum role: ROLES

  # scope :with_full_access, -> { where(role: ROLE[:full_access]) }
  # scope :with_restricted_access, -> { where(role: ROLES[:restricted_access]) }
  scope :with_restricted_access, -> { with_role(Role.availables[1]) }

  def checked_roles
    self.roles.map do |role|
      role.name
    end
  end

  def roles_descriptions
    self.roles.map do |role|
      Role::ROLES[role.name.to_sym]
    end
  end
end

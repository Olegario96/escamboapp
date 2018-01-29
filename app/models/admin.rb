class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = {:full_access => 0, :restricted_access => 1}

  enum role: ROLES

  scope :with_full_access, -> { where(role: ROLE[:full_access]) }
  scope :with_restricted_access, -> { where(role: ROLES[:restricted_access]) }
end

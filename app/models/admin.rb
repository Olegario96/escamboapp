class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :with_full_access, -> { where(role: 'full_access') }

  enum role: [:full_access, :restricted_access]

  def role_description
    if self.role == 'full_access'
      'Acesso total'
    else
      'Acesso restrito'
    end
  end
end

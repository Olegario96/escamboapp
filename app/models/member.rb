class Member < ActiveRecord::Base
  has_many :ads
  has_one :profile_member
  accepts_nested_attributes_for :profile_member

  ratyrate_rater

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private

    def nested_attributes
      if nested_attributes_blank?
        errors.add(:base, 'É necessário preencher o primeiro e segundo nome')
      end
    end

    def nested_attributes_blank?
      profile.member.first_name.blank? || profile.member.second_name.blank?
    end
end

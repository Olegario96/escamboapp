class Role < ActiveRecord::Base
    ROLES = {
      full_access: 'Acesso completo',
      restricted_access: 'Acesso Restrito'
    }

    def self.availables
      ROLES.map { |key, value| key.to_s }
    end

    has_and_belongs_to_many :admins, :join_table => :admins_roles


    belongs_to :resource,
               :polymorphic => true


    validates :resource_type,
              :inclusion => { :in => Rolify.resource_types },
              :allow_nil => true

    validates :name, inclusion: { in: Role.availables }
    scopify
end

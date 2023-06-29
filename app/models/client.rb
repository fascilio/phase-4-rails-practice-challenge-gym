class Client < ApplicationRecord
    has_many :memberships
    has_many :gyms, through: :memberships

    validates :name, presence: true
    validates :age, numericality: { greater_than_or_equal_to: 18 }
end

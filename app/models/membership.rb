class Membership < ApplicationRecord
  belongs_to :gym
  belongs_to :client

  validates :client_id, uniqueness: { scope: :gym_id, message: "Client can have only one membership with gym" }
end

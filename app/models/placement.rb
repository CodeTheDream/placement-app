class Placement < ApplicationRecord
    belongs_to :licensee
    has_one :service
    has_many :comments
    has_many :cart_placements
    has_many :carts, through: :cart_placements
end

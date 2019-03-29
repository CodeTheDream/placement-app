class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_placements
    has_many :placements, through: :cart_placements
end

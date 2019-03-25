class Licensee < ApplicationRecord
    has_many :placements
    has_many :comments , through: :placements
end

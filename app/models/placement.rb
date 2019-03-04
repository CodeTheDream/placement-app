class Placement < ApplicationRecord
    belongs_to :licensee
    has_one :service
    has_many :comments
end

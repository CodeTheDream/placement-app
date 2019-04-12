# Bulletin board announcement model

class Announcement < ApplicationRecord
    belongs_to :user
    belongs_to :placement, optional: true
    belongs_to :licensee, optional: true
end

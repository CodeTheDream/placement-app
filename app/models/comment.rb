class Comment < ApplicationRecord
    belongs_to :placement
    belongs_to :user
end

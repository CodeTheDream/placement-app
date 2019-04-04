# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :placement
  belongs_to :user
  has_one :licensee, through: :placement
end

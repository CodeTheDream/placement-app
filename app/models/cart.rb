# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_placements, dependent: :destroy
  has_many :placements, through: :cart_placements
end

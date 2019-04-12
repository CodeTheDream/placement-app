# frozen_string_literal: true

class Licensee < ApplicationRecord
  has_many :placements, dependent: :destroy
  has_many :comments, through: :placements
end

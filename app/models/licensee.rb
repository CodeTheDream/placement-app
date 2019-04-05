# frozen_string_literal: true

class Licensee < ApplicationRecord
  has_many :placements
  has_many :comments, through: :placements
end

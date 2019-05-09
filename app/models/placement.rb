# frozen_string_literal: true

class Placement < ApplicationRecord
  
  include PgSearch
  pg_search_scope :search_for, against: [:name, :city, :county]
  
  belongs_to :licensee
  has_one :service
  has_many :comments
  has_many :cart_placements
  has_many :carts, through: :cart_placements
end

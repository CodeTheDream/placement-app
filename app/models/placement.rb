# frozen_string_literal: true

class Placement < ApplicationRecord
  
  include PgSearch
  pg_search_scope :search_for, against: [:name, :city, :county]
  
  belongs_to :licensee
  has_one :service
  has_many :comments
  has_many :cart_placements
  has_many :carts, through: :cart_placements
  attr_accessor :full_address, :latitude, :longitude
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.full_address.present? && obj.address_changed? }
  
  def full_address
    [address, city, state, zip].compact.join(', ')
  end
end


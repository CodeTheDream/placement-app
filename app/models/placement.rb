# frozen_string_literal: true

class Placement < ApplicationRecord
  
  include PgSearch
  pg_search_scope :search_for, against: [:name, :city, :county]
  
  belongs_to :licensee
  has_one :service
  has_many :comments
  has_many :cart_placements
  has_many :carts, through: :cart_placements
  validates :name, presence: true
  # attr_accessible :full_address, :latitude, :longitude
  geocoded_by :full_address_1
  after_validation :geocode, if: ->(obj) { obj.full_address_1.present? && obj.address_changed? }
  def full_address_1
    [address, city, state, zip].compact.join(', ')
  end  
  
  # def coordinates
  #   [latitude, longitude]
  # end
end


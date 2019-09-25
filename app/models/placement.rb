# frozen_string_literal: true

class Placement < ApplicationRecord
  
  include PgSearch
  def service_name
    service.name
  end
  
  pg_search_scope :search_for,
    against: [:name, :address, :city, :zip, :phone],
    associated_against: {
      county: [:name, :mco, :hospital],
      licensee: :facility_name,
      service: [:name, :prog_code]
    },
    using: {tsearch: {dictionary: "english", prefix: "true"}}

  pg_search_scope :filter_county,
    against: [:county_id]
    
  pg_search_scope :filter_service,
    against: [:service_id]
  
  pg_search_scope :filter_mco,
    associated_against: {
      county: [:mco]
    }
    
  pg_search_scope :filter_hospital,
    associated_against: {
      county: [:hospital]
    }
    
  belongs_to :licensee
  belongs_to :service
  belongs_to :county
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
  
end


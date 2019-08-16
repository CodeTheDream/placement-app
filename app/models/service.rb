# frozen_string_literal: true

class Service < ApplicationRecord
    #include PgSearch
    #pg_search_scope :search_services, against: [:name]
    
  has_many :placements
end

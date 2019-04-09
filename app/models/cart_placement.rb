# frozen_string_literal: true

class CartPlacement < ApplicationRecord
  belongs_to :cart
  belongs_to :placement
end

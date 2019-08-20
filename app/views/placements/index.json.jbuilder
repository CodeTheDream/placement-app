json.array! @placements do |placement|
  json.lat placement.latitude
  json.lng placement.longitude
  json.title placement.name
  json.content PlacementsController.render(partial: 'placements/placement',
                                           locals: { placement: placement },
                                           format: :html).squish
end


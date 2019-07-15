class PlacementsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".ods" then Roo::OpenOffice.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_placements
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      placement = Placement.find_by_id(row["id"]) || Placement.new
      placement.name = row["name"]
      placement.address = row["address"]
      placement.city = row["city"]
      placement.state = row["state"]
      placement.zip = row["zip"]
      placement.county = row["county"]
      placement.phone = row["phone"]
      licensee = Licensee.find_by(facility_name: row["licensee.facility_name"])
      placement.licensee_id = licensee.id
      placement.gender = row["gender"]
      placement.beds = row["beds"]
      service = Service.find_by(prog_code: row["service.prog_code"])
      placement.service_id = service.id
      placement
      
      #placement.attributes = row.to_hash
      #placement
    end
  end

  def imported_placements
    @imported_placements ||= load_imported_placements
  end

  def save
    if imported_placements.map(&:valid?).all?
      imported_placements.each(&:save!)
      true
    else
      imported_placements.each_with_index do |placement, index|
        placement.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end
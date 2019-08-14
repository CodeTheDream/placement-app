class LicenseesImport
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

  def load_imported_licensees
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(5)
    (6..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      licensee = Licensee.find_by_id(row["id"]) || Licensee.new
      licensee.attributes = row.to_hash
      licensee
    end
  end

  def imported_licensees
    @imported_licensees ||= load_imported_licensees
  end

  def save
    if imported_licensees.map(&:valid?).all?
      imported_licensees.each(&:save!)
      true
    else
      imported_licensees.each_with_index do |licensee, index|
        licensee.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end
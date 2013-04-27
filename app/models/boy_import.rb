class BoyImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_boys.map(&:valid?).all?
      imported_boys.each(&:save!)
      true
    else
      imported_boys.each_with_index do |boy, index|
        boy.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_boys
    @imported_boys ||= load_imported_boys
  end

  def load_imported_boys
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(4)
    (5..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      boy = Repository.find_by_partName(row["partName"]) || Repository.new
#      boy.attributes = row.to_hash.slice(*Repository.accessible_attributes)
      if row.to_hash['sitution']=='add'
      boy.quantity=(boy.quantity.to_i+row.to_hash['quantity'].to_i).to_s
      else 
      boy.quantity=(boy.quantity.to_i-row.to_hash['quantity'].to_i).to_s
      end
      boy
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end

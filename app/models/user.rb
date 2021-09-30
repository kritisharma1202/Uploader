class User < ApplicationRecord
  require 'roo'
  require 'csv'
  require 'iconv'
  validates :FIRST_NAME, :LAST_NAME, presence: true
  validates :EMAIL_ID, uniqueness: true

  def self.import(file)
    @error_msgs = []
    @row_count = 0
    @error_count = 0
    existing_records = User.count
    spreadsheets = open_spreadsheet(file)
    spreadsheets.sheets.each do |spreadsheet|
      import_via_sheet(spreadsheets.sheet(spreadsheet))
    end
    @new_count = User.count-existing_records
    return @row_count, @new_count, @error_count, @error_msgs
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.import_via_sheet(spreadsheet)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      @row_count +=1
      row = Hash[[header, spreadsheet.row(i)].transpose]

      begin
        User.create!(row)
      rescue => error
        @error_count +=1
        @error_msgs << "#{row.inspect} - #{error.message}"
      end
    end
  end
end

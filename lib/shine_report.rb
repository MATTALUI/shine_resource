class ShineReport
  attr_reader :note_groups
  attr_reader :filename
  attr_reader :file
  attr_reader :path

  def initialize(note_groups)
    @note_groups = note_groups
    @filename = filename_gen
    @path = File.join(Rails.root, @note_groups.first.id,@filename)
    @organization = @note_groups.first.caretaker.organization
    self.process
  end

  def process
    book = Spreadsheet::Workbook.new

    clients_sheet = book.create_worksheet :name => 'Client Report'
    clients_sheet.row(0).concat(shine_report_client_headings)

    time_sheet = book.create_worksheet name: "Mileage and Timesheet"
    time_sheet.row(0).concat(shine_report_timesheet_headings)

    client_index = 1
    time_index   = 1
    @note_groups.each do |group|
      group.notes.each do |note|
        row = []
        row << note.client.to_s
        row << group.date.strftime("%-m/%-d/%Y")
        start_time = note.start_time + (@organization.utc_offset.hours)
        row << start_time.strftime("%l:%M%p")
        end_time = note.end_time + (@organization.utc_offset.hours)
        row << end_time.strftime("%l:%M%p")
        row << group.total_hours
        row << note.service_description
        row << note.transportation_trips
        row << note.location
        row << note.interactions
        row << note.support_provided
        row << note.comments
        row << false
        row << group.caretaker.email
        clients_sheet.row(client_index).concat(row)
        client_index += 1
      end

      group_time_data = []
      # Date
      group_time_data << group.date.strftime("%-m/%-d/%Y")
      # Miles
      group_time_data << nil
      # SCC Hours
      group_time_data << nil
      # Hours Spent Driving
      group_time_data << nil
      # Total Time 1
      group_time_data << nil
      # Total Time 2
      group_time_data << (group.end_time - group.start_time)/60/60

      time_sheet.row(time_index).concat(group_time_data)
      time_index += 1
    end
    @notes_group
    time_sheet.row(time_index).concat(["Totals", 0, 0, 0, 0])

    @path = 'test.xls'
    book.write @path
  end

  def destroy
  end

  private
  def filename_gen
    return (1..10).map{[*'a'..'z',*'A'..'Z'].sample}.join('') + ".xls"
  end

  def shine_report_client_headings
    return ["Client", "Date", "Start Time", "End Time", "Total Hours", "Service Provided", "Transportation Trips", "What/Where? (locations and activities)", "People Client Interacted With", "Support Staff Provided", "Comments/Outcome", "Incident Report Filed?", "Email Address"]
  end

  def shine_report_timesheet_headings
    return ["Dates", "Miles", "SCC Hours", "Hours Spent Driving (Not During SCC)", "Time Spent Out For The Day (Decimal)", "Total Time SPent Out For The Day (Hour)"]
  end
end

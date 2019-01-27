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
    total_miles  = 0
    total_hours  = 0
    @note_groups.each do |group|
      group.notes.each do |note|
        row = []
        # Client
        row << note.client.to_s
        # Date
        row << group.date.strftime("%-m/%-d/%Y")
        # Start Time
        start_time = note.start_time + (@organization.utc_offset.hours)
        row << start_time.strftime("%l:%M%p")
        # End Time
        end_time = note.end_time + (@organization.utc_offset.hours)
        row << end_time.strftime("%l:%M%p")
        # Total Hours
        row << note.total_hours
        # Service Desctiption
        row << note.service_description
        # Transportation Trips
        row << note.transportation_trips
        # What/Where?
        row << note.location
        # People Client Interacted With
        row << note.interactions
        # Support Staff Provided
        row << note.support_provided
        # Comments/Outcome
        row << note.comments
        # Incident Report Filed
        row << note.incident_report?
        # Email
        row << group.caretaker.email
        clients_sheet.row(client_index).concat(row)
        client_index += 1
      end

      group_time_data = []
      # Date
      group_time_data << group.date.strftime("%-m/%-d/%Y")
      # Miles
      total_miles += group.miles
      group_time_data << group.miles
      # Total Time 1
      total_hours += group.total_hours
      group_time_data << group.total_hours
      # Total Time 2 timestamp
      start_time = group.start_time + (@organization.utc_offset.hours)
      start_time = start_time.strftime("%l:%M%p")
      end_time = group.end_time + (@organization.utc_offset.hours)
      end_time = end_time.strftime("%l:%M%p")
      group_time_data << "#{start_time}-#{end_time}"

      time_sheet.row(time_index).concat(group_time_data)
      time_index += 1
    end
    @notes_group
    time_sheet.row(time_index).concat(["Totals", total_miles, total_hours])

    dir_name = File.join(Rails.root, "public", "system", "reports", filename_gen)
    FileUtils.mkdir_p(dir_name)
    @path = File.join(dir_name, "report.xls")
    book.write @path
  end

  def destroy
    FileUtils.rm_rf(@path)
  end

  private
  def filename_gen
    return (1..10).map{[*'a'..'z',*'A'..'Z'].sample}.join('')
  end

  def shine_report_client_headings
    return ["Client", "Date", "Start Time", "End Time", "Total Hours", "Service Provided", "Transportation Trips", "What/Where? (locations and activities)", "People Client Interacted With", "Support Staff Provided", "Comments/Outcome", "Incident Report Filed?", "Email Address"]
  end

  def shine_report_timesheet_headings
    return ["Dates", "Miles", "Time Spent Out For The Day (Decimal)", "Total Time SPent Out For The Day (Hour)"]
  end
end

class NotesGroupController < ApplicationController
  include ActiveSupport
  def index
    if current_user.master
      @note_groups = NoteGroup.organization(current_organization.id).order(date: :desc)
      generate_master_report
    else
      @note_groups = current_user.note_groups.order(date: :desc)
    end
  end

  def show
    @note_group = NoteGroup.find(params[:id])
    @notes = @note_group.notes.includes(:client)
  end

  def new
    @clients = Client.with_org(current_user.organization.id)
    @presets = Preset.active.caretaker(current_user.id).client_neutral.group_by(&:preset_type)
  end

  def create
    param_notes = params[:note_group]

    @note_group = NoteGroup.new
    @note_group.caretaker_id = param_notes[:caretaker_id]
    @note_group.date = Date.parse(param_notes[:date])
    @note_group.start_time = Time.parse(param_notes[:start_time] << " #{current_user.utc_offset}")
    @note_group.end_time = Time.parse(param_notes[:end_time]  << " #{current_user.utc_offset}")
    @note_group.total_hours = (@note_group.end_time - @note_group.start_time)/1.hour
    @note_group.billed_for = false
    @note_group.save

    # create individual notes for each client

    notes = []
    template = {
      note_group_id: @note_group.id,
      start_time: @note_group.start_time,
      end_time: @note_group.end_time,
      service_description: param_notes[:service_description],
      transportation_trips: param_notes[:transportation_trips],
      location: param_notes[:location],
      interactions: param_notes[:interactions],
      support_provided: param_notes[:support_provided],
      comments: param_notes[:comments],
    }
    Client.where(id: param_notes[:client_id]).each do |client|
      notes << template.merge({ client_id: client.id })
    end
    notes = Note.create(notes)

    redirect_to new_notes_group_note_path(notes_group_id: @note_group)

  end

  def shine_report
    start_date = Date.parse(params.dig(:generator, :start_date)).beginning_of_day
    end_date   = Date.parse(params.dig(:generator, :end_date)).end_of_day
    @organization = current_user.organization
    @note_groups = NoteGroup.caretaker(current_user.id).between_dates(start_date, end_date).order(date: :asc)

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
        row << current_user.email
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

    file_name = (1..10).map{[*'a'..'z',*'A'..'Z'].sample}.join('') + ".xls"
    book.write file_name
    send_file  file_name


    # redirect_to root_path
  end

  private
  def note_group_params
    params.require(:note_group).permit(:start_time, :end_time, :caretaker_id, :date, :total_hours, :billed_for)
  end

  def shine_report_client_headings
    return ["Client", "Date", "Start Time", "End Time", "Total Hours", "Service Provided", "Transportation Trips", "What/Where? (locations and activities)", "People Client Interacted With", "Support Staff Provided", "Comments/Outcome", "Incident Report Filed?", "Email Address"]
  end

  def shine_report_timesheet_headings
    return ["Dates", "Miles", "SCC Hours", "Hours Spent Driving (Not During SCC)", "Time Spent Out For The Day (Decimal)", "Total Time SPent Out For The Day (Hour)"]
  end

  def generate_master_report
    @total_reports    = @note_groups.count
    @unbilled_reports = @note_groups.unbilled
    @unbilled_count   = @unbilled_reports.count
    @unbilled_hours   = @unbilled_reports.sum(&:total_hours)
  end
end

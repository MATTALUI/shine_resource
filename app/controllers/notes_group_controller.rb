class NotesGroupController < ApplicationController
  include ActiveSupport
  def index
    @note_groups = current_user.note_groups.order(date: :desc)
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
    @note_groups = NoteGroup.caretaker(current_user.id).between_dates(start_date, end_date)

    book = Spreadsheet::Workbook.new


    clients_sheet = book.create_worksheet :name => 'Client Report'
    clients_sheet.row(0).concat(shine_report_client_headings)
    index = 1
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
        clients_sheet.row(index).concat(row)
        index += 1
      end
    end

    book.write 'test.xls'


    redirect_to root_path
  end

  private
  def note_group_params
    params.require(:note_group).permit(:start_time, :end_time, :caretaker_id, :date, :total_hours, :billed_for)
  end

  def shine_report_client_headings
    return ["Client", "Date", "Start Time", "End Time", "Total Hours", "Service Provided", "Transportation Trips", "What/Where? (locations and activities)", "People Client Interacted With", "Support Staff Provided", "Comments/Outcome", "Incident Report Filed?", "Email Address"]
  end
end

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
    @note_group.miles = param_notes[:miles].to_i

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

    report = ShineReport.new(@note_groups)
    send_file  report.path
    report.destroy
  end

  private
  def note_group_params
    params.require(:note_group).permit(:start_time, :end_time, :caretaker_id, :date, :total_hours, :billed_for, :miles)
  end

  def generate_master_report
    @total_reports    = @note_groups.count
    @unbilled_reports = @note_groups.unbilled
    @unbilled_count   = @unbilled_reports.count
    @unbilled_hours   = @unbilled_reports.sum(&:total_hours)
  end
end

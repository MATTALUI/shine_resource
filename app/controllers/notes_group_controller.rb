class NotesGroupController < ApplicationController
  include ActiveSupport
  def index
    if current_user.master
      @note_groups = NoteGroup.organization(current_organization.id).order(date: :desc)
      @incident_report = Note.where(note_group_id: @note_groups.map(&:id)).includes(:incident_report).inject({}) do |acc, note|
        acc[note.note_group_id] = true if note.incident_report.present?
        acc
      end
      generate_master_report if current_user.master
    else
      @note_groups = current_user.note_groups.order(date: :desc)
    end
  end

  def show
    @note_group = NoteGroup.find(params[:id])
    @notes = @note_group.notes.includes(:client, :incident_report)
  end

  def new
    if params[:clear_ng_template].present?
      delete_notes_group_template
      return redirect_to new_notes_group_path # This is a trick to make sure the param doesn't stay.
    end
    load_notes_group_template
    @clients = Client.with_org(current_user.organization.id)
    @presets = Preset.active.caretaker(current_user.id).client_neutral.group_by(&:preset_type)
    @service_types = ServiceType.for_org(current_user.organization_id).active
  end

  def create
    delete_notes_group_template
    param_notes = params[:note_group]

    @note_group = NoteGroup.new
    @note_group.caretaker_id = param_notes[:caretaker_id]
    @note_group.date = Date.parse(param_notes[:date])
    @note_group.start_time = Time.parse(param_notes[:start_time] + " #{current_user.timezone_short_name}")
    @note_group.end_time = Time.parse(param_notes[:end_time]  + " #{current_user.timezone_short_name}")
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
      service_type_id: param_notes[:service_type_id]
    }
    Client.where(id: param_notes[:client_id]).each do |client|
      notes << template.merge({ client_id: client.id })
    end
    notes = Note.create(notes)
    notes.each(&:sub_client)

    redirect_to new_notes_group_note_path(notes_group_id: @note_group)

  end

  def shine_report
    start_date = Date.parse(params.dig(:generator, :start_date)).beginning_of_day
    end_date   = Date.parse(params.dig(:generator, :end_date)).end_of_day
    @organization = current_user.organization
    @note_groups = NoteGroup.caretaker(current_user.id).between_dates(start_date, end_date).order(date: :asc)

    report = ShineReport.new(@note_groups)
    send_file  report.path

    # XXX: can't destroy the path quite yet because it interrupts file sending.
    # report.destroy # thou shalt tidy up!!
  end

  def template_cache
    load_notes_group_template
    new_values = {
      params[:id] => params[:value]
    }
    @ng_template.merge!(new_values)
    save_notes_group_template
    respond_to do |format|
      format.json { render :json => @ng_template }
    end
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

  def load_notes_group_template
    session[:ng_template] = {}.to_json if session[:ng_template].blank?
    @ng_template = JSON.decode(session[:ng_template]).with_indifferent_access
  # rescue
  #   @ng_template = {}
  end

  def save_notes_group_template
    session[:ng_template] = @ng_template.to_json
  end

  def delete_notes_group_template
    session.delete(:ng_template)
  end

end

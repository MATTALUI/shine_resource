class NotesController < ApplicationController
  before_action :set_note_group
  def index
    # @note_groups = current_user.note_groups
  end

  def show
    @note = Note.find(params[:id])
    @client = @note.client
    @incident_report = @note.incident_report
  end

  def new
    @notes = @note_group.notes.includes(:client)
    @presets = Preset.active.caretaker(current_user.id).group_by(&:client_id)
    @service_types = ServiceType.active.for_org(current_user.organization_id)
  end

  def create
    params[:updates].each do |client_id, note|
      note[:start_time] = Time.parse(note[:start_time] + " #{current_user.timezone_short_name}")
      note[:end_time]   = Time.parse(note[:end_time] + " #{current_user.timezone_short_name}")
    end
    @note_group.notes.where(client_id: params[:updates].keys).each do |note|
      update = params[:updates][note.client_id]
      note.update(update.permit(:location, :start_time, :end_time, :service_description, :transportation_trips, :interactions, :support_provided, :comments, :service_type_id))
      if update[:incident_report][:incident_report_filed] == "true"
        incident_report = update[:incident_report]
        report = IncidentReport.new
        report.note_id = note.id
        report.client_id = note.client_id
        report.caretaker_id = current_user.id
        report.organization_id = note.client.organization_id
        report.date = note.note_group.date
        report.start_time = incident_report[:start_time]
        [:description, :codes, :location, :duration, :observed_directly, :likely_to_reoccur, :hrc_review, :ap_review, :law_review, :critical, :followup_needed, :preface, :action_taken, :alternative_action, :witnesses, :followup, :comments].each do |key|
          report.public_send("#{key.to_s}=", incident_report[key])
        end
        report.save
      end
      note.sub_client
    end
    redirect_to notes_group_index_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_note_group
    @note_group = NoteGroup.find(params[:notes_group_id])
  end
end

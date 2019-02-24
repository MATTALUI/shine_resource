class NotesController < ApplicationController
  before_action :set_note_group
  def index
    # @note_groups = current_user.note_groups
  end

  def show
    @note = Note.find(params[:id])
    @client = @note.client
  end

  def new
    @notes = @note_group.notes.includes(:client)
    @presets = Preset.active.caretaker(current_user.id).group_by(&:client_id)
    @service_types = ServiceType.active.for_org(current_user.organization_id)
  end

  def create
    params[:updates].each do |client_id, note|
      note[:start_time] = note[:start_time] << " #{current_user.utc_offset}"
      note[:end_time]   = note[:end_time] << " #{current_user.utc_offset}"
    end
    @note_group.notes.where(client_id: params[:updates].keys).each do |note|
      update = params[:updates][note.client_id]
      if update[:incedent_report].present?
        body = update[:incedent_report]
        report = IncidentReport.new
        report.note_id = note.id
        report.client_id = note.client_id
        report.caretaker_id = current_user.id
        report.body = body
        report.save
      end
      note.update(update.permit(:location, :start_time, :end_time, :service_description, :transportation_trips, :interactions, :support_provided, :comments, :service_type_id))
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

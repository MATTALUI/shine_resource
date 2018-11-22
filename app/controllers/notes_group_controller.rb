class NotesGroupController < ApplicationController
  def index
    @note_groups = current_user.note_groups.order(date: :desc)
  end

  def show
    @note_group = NoteGroup.find(params[:id])
    @notes = @note_group.notes.includes(:client)
  end

  def new
    @clients = Client.with_org(current_user.organization.id)
  end

  def create
    param_notes = params[:note_group]

    @note_group = NoteGroup.new
    @note_group.caretaker_id = param_notes[:caretaker_id]
    @note_group.date = Date.parse(param_notes[:date])
    @note_group.start_time = Time.parse(param_notes[:start_time])
    @note_group.end_time = Time.parse(param_notes[:end_time])
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
    Note.create(notes)

    redirect_to new_notes_group_note_path(notes_group_id: @note_group)

  end

  private
  def note_group_params
    params.require(:note_group).permit(:start_time, :end_time, :caretaker_id, :date, :total_hours, :billed_for)
  end
end

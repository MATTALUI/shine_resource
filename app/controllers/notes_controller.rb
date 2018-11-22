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
  end

  def create
    @note_group.notes.where(client_id: params[:updates].keys).each do |note|
      note.update(params[:updates][note.id])
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

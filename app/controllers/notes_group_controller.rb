class NotesGroupController < ApplicationController
  def index
    @note_groups = current_user.note_groups
  end

  def show
    @note_group = NoteGroup.find(params[:id])
    @notes = @note_group.notes.includes(:client)
  end
end

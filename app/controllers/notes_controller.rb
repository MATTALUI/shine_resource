class NotesController < ApplicationController
  def index
    # @note_groups = current_user.note_groups
  end

  def show
    @note_group = NoteGroup.find(params[:notes_group_id])
    @note = Note.find(params[:id])
    @client = @note.client
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

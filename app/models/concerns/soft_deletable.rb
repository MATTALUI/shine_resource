module SoftDeletable
  extend ActiveSupport::Concern
  included do
    # Scopes
    scope :without_deleted, -> { where(mark_as_deleted: false) }
    scope :with_deleted,    -> { where(mark_as_deleted: [true, false]) }
    scope :just_deleted,    -> { where(mark_as_deleted: true)}

    # Methods
    # Set record as deleted
    # @return [Boolean]
    def soft_delete!
      update_attribute(:mark_as_deleted, true)
    end

    # Set record as not deleted
    # @return [Boolean]
    def soft_restore!
      update_attribute(:mark_as_deleted, false)
    end

    # Is record marked as deleted
    # @return [Boolean]
    def soft_deleted?
      mark_as_deleted
    end
  end
end
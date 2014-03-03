class Section < ActiveRecord::Base

  # RELATIONSHIPS
  belongs_to :page
  has_many :section_edits
  has_many :editors, through: :section_edits, class_name: "AdminUser"

  # GEM
  acts_as_list scope: :page # this will add in all that funtionality of the 'acts_as_list' Ruby gem, providing intelligence about how to deal with the row position of an object in a table.

  # CALLBACKS
  after_save :touch_page

  # VALIDATIONS
  CONTENT_TYPES = ['text', 'HTML']
  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
    :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content # a section's no good if we don't have content to show to the user

  # SCOPES
  scope :visible, lambda { where(visible: true) } # I can call section.visible and I can get my visible sections.
  scope :invisible, lambda { where(visible: false) } # I can call section.invisible and I can get my invisible sections.
  scope :sorted, lambda { order("sections.position ASC") }
  scope :newest_first, lambda { order("sections.created_at DESC") }

  private

    def touch_page
      # touch is similar to:
      # page.update_attribute(:updated_at, Time.now) <--updating the attribute, "updated_at" & setting it to Time.now ; will update the timestamp for the page ; anytime this section is updated, let's ALSO update the page at the same time
      page.touch
    end

end

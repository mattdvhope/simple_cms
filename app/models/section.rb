class Section < ActiveRecord::Base

  # RELATIONSHIPS
  belongs_to :page
  has_many :section_edits
  has_many :editors, through: :section_edits, class_name: "AdminUser"

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

end

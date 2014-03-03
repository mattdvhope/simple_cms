class Page < ActiveRecord::Base

  # RELATIONSHIPS
  belongs_to :subject
  # has_and_belongs_to_many :admin_users, :join_table => "admin_users_pages"
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  has_many :sections

  # GEM
  acts_as_list :scope => :subject # this will add in all that funtionality of the 'acts_as_list' Ruby gem, providing intelligence about how to deal with the row position of an object in a table.
                # the :scope above tells this page that its position is only within a particular subject; not in a position compared to ALL pages; thus having multiple number 1's (or 2's, etc) will not create a conflict, because it will check for positions based on thes subject.id

  # CALLBACKS
  before_validation :add_default_permalink # This says: "If the user does not provide me with a permalink, I will provide one for them."  I'll do this BEFORE the validations take over (b/c the validations are looking for 'validates_presence_of' and 'validates_length_of')!
  after_save :touch_subject # this is going to happen for both 'create' and 'update'.
  after_destroy :delete_related_sections # We'll leave this turned off for now.

  # VALIDATIONS
  validates_presence_of :name # order of validations on the lines is important
  validates_length_of :name, maximum: 255
  validates_presence_of :permalink
  validates_length_of :permalink, within: 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink # :permalink is the way that we locate each of these pages, otherwise we won't know which page the user is looking for--therefore it MUST be unique; it validates_uniqueness_of issues a call the database, unlike the other validations
  # for unique values by subject use ":scope => :subject_id"

  # SCOPES
  scope :visible, lambda { where(visible: true) } # I can call page.visible and I can get my visible pages.
  scope :invisible, lambda { where(visible: false) } # I can call page.invisible and I can get my invisible pages.
  scope :sorted, lambda { order("pages.position ASC") }
  scope :newest_first, lambda { order("pages.created_at DESC") }

  private

    def add_default_permalink
      if permalink.blank?
        self.permalink = "#{id}-#{name.parameterize}" # Whenever you're setting an attribute in a Model, it's always a good idea to use 'self.' before the attribute.
      end                       # 'parameterize' is going to take this name string and turn it into something that is suitable for use in the URL (the name with dashes, all lowercase, removes all bad symbols).
    end

    def touch_subject
      # touch is similar to:
      # subject.update_attribute(:updated_at, Time.now) <--updating the attribute, "updated_at" & setting it to Time.now ; will update the timestamp for the subject ; anytime this page is updated, let's ALSO update the subject at the same time
      subject.touch
    end

    def delete_related_sections # With this, if we delete a page, we'll be sure to also delete all the sections in it/related to it.
      self.sections.each do |section|
        # Or perhaps instead of destroy, you would
        # move them to a another page.
        # section.destroy
      end      
    end

end

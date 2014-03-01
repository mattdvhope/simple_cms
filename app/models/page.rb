class Page < ActiveRecord::Base

  # RELATIONSHIPS
  belongs_to :subject
  # has_and_belongs_to_many :admin_users, :join_table => "admin_users_pages"
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  has_many :sections

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

end

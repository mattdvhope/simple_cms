class Subject < ActiveRecord::Base

  # RELATIONSHIPS
  # We could delete related pages automatically
  # whenever a subject is deleted, using..
  # has_many :pages, :dependent => :destroy <-- This deletes everything in the tree below it.
  has_many :pages

  acts_as_list # this will add in all that funtionality of the 'acts_as_list' Ruby gem, providing intelligence about how to deal with the row position of an object in a table.

  # VALIDATIONS
  # Don't need to validate (in most cases):
  #   ids, foreign keys, timestamps, booleans, counters
  validates_presence_of :name
  validates_length_of :name, maximum: 255
    # validates_presence_of vs. validates_length_of :minimum => 1
    # different error messages: "can't be blank" or "is too short"
    # validates_length_of allows strings with only spaces also (in addition to characters)! That's not what we'd want. That's why we want validates_presence_of before this, b/c validates_presence_of DOES look for actual characters and not for spaces.

  # SCOPES
  scope :visible, lambda { where(visible: true) } # I can call subject.visible and I can get my visible subjects.
  scope :invisible, lambda { where(visible: false) } # I can call subject.invisible and I can get my invisible subjects.
  scope :sorted, lambda { order("subjects.position ASC") }
  scope :newest_first, lambda { order("subjects.created_at DESC") }
  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])
  }

end

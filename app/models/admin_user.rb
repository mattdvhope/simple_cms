class AdminUser < ActiveRecord::Base

  # To configure a different table name:
  # self.table_name = "admin_users"

  has_secure_password # this one line does many things for you (see notes)

  # RELATIONSHIPS
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits #use this b/c it's a 'rich' join table that we're reaching across rather than a 'simple' join table

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

  # VALIDATIONS
  # validates_presence_of :first_name
  # validates_length_of :first_name, maximum: 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, maximum: 25
  # validates_presence_of :username
  # validates_length_of :username, within: 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, maximum: 100
  # validates_format_of :email, with: EMAIL_REGEX
  # validates_confirmation_of :email # this adds a virtual attribute called 'email_confirmation', and then if that value is there, it makes sure to match it with the previously entered email

  # short-cut validations
  validates :first_name, presence: true,
                          length: {maximum: 25}
  validates :last_name, presence: true,
                          length: {maximum: 50}
  validates :username, length: { within: 8..50},
                          uniqueness: true
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: EMAIL_REGEX,
                    confirmation: true
  # Custom validations:
  validate :username_is_allowed
  # validate :no_new_users_on_saturday, :on => :create # this custom validation won't run if the user is updating the record--only when creating a new record

  def username_is_allowed #same as 'validates_exclusion_of' method
    if FORBIDDEN_USERNAMES.include?(username) # checking to see if the username is in FORBIDDEN_USERNAMES
      errors.add(:username, "has been restricted from use.") # if the username is in FORBIDDEN_USERNAMES, it will add an error to the errors array
    end
  end

  # Errors not related to a specific attribute
  # can be added to the errors[:base] which is also known as 'the base error object'
  def no_new_users_on_saturday
    if Time.new.wday == 6 # #wday returns the 'day of the week'; 6 would be equal to Saturday
      errors[:base] << "No new users of Saturdays."
    end
  end

end

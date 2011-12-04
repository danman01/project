class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class BetaSignup < ActiveRecord::Base
  
  belongs_to :region
  belongs_to :city
  has_and_belongs_to_many :roles
  geocoded_by :ip_address,
    :latitude => :lat, :longitude => :lng
  after_validation :geocode
  
  validates :email, :name, :zip, :roles, :presence=>true
  validates :email, :uniqueness=>true, :email=>true
  validates_format_of :zip, :with=>/^[0-9]{5}$/, :message=>"Please enter your 5 digit zip code"
  
end

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
  
  validates :email, :name, :region_id, :city_id, :presence=>true
  validates :email, :uniqueness=>true, :email=>true
end

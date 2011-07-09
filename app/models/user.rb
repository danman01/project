# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  street                 :string(255)
#  city                   :string(255)
#  region                 :string(255)
#  country                :string(255)
#  phone                  :string(255)
#  notes                  :string(255)
#  ticket_ids             :string(255)
#  event_ids              :string(255)
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :street, :city, :region, :phone, :country, :remember_me
  
  before_create :set_role
  
  has_many :tickets
  has_many :invoices
  has_many :events, :through=> :tickets
  has_many :artists, :through=>:tickets
  has_many :venues, :through=>:tickets
  has_many :sales, :through=>:invoices
  has_many :commissions
  def role?(role)
    self.roles.find_by_name(role.to_s) ? true : false
  end
  def set_role
     self.roles=[Role.find_by_name("basic")]
   end
end

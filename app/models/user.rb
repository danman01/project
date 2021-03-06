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
#  role_ids               :string(255)
#  complete               :boolean         default(FALSE)
#

class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :street, :city, :region, :phone, :country, :remember_me, :role_ids
  
  #before_create :set_role
  has_many :locations, :through => :locations_users
  has_many :locations_users
  
  has_many :addresses, :through=> :addresses_users
  has_many :addresses_users
  
  has_many :ratings
  has_many :custom_tickets
  has_many :tickets
  has_many :ticket_groups, :through =>:my_ticket_groups
  has_many :my_ticket_groups
  has_many :invoices
  has_many :events, :through=> :tickets
  has_many :artists, :through=>:tickets
  has_many :venues, :through=>:tickets
  has_many :sales, :through=>:invoices
  has_many :commissions
  after_create :set_role
  
  def current_rating(buyerOrSeller)
    ratings = self.ratings
    if !ratings.empty?
      buyer_ratings = []
      seller_ratings = []
      self.ratings.each do |r|
        buyer_ratings << r.rating unless r.buyer_id!=self.id
        seller_ratings << r.rating unless r.seller_id!=self.id
      end
      case buyerOrSeller
      when "buyer"
        output = buyer_ratings.inject{ |sum, el| sum + el }.to_f / buyer_ratings.size
        output = output.to_f
        
      when "seller"
        output = seller_ratings.inject{ |sum, el| sum + el }.to_f / seller_ratings.size
        output = output.to_f
      end
    end
    # TODO whats sprintf
      return sprintf("%.1f", output)
  end
  
  def rated_by_this_user?(user)
    i = 0
    self.ratings.each do |r|
      if r.seller_id == user || r.buyer_id == user
        i = 1
      end
    end
    return true if i == 1
  end
  
  def role?(role)
    #takes role name or role id
    #if role.class==String
    self.roles.find_by_name(role.to_s) ? true : false 
    #else
    #self.roles.include?(Role.find(role)) ? true : false
    #end
  end
  def set_role
    if self.roles.empty?
      self.roles=Role.find_all_by_name(["basic"])
      self.save
   end
  end
end

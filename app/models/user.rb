class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :tickets
  has_many :invoices
  has_many :events, :through=> :tickets
  has_many :artists, :through=>:tickets
  has_many :venues, :through=>:tickets
  has_many :sales, :through=>:invoices
end

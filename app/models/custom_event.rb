class CustomEvent < ActiveRecord::Base
  has_many :custom_tickets
  has_many :ticket_groups
  belongs_to :venue
  has_attached_file :image, :styles => { :medium => "350x350>", :thumb => "100x100>" }
  
  #attr_accessor :is_custom_event
  
end

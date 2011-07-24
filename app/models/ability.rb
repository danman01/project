class Ability 
  include CanCan::Ability

    def initialize(user)
      user ||= User.new # guest user
        can :read, :all
        can :create, Venue
        can :edit, Venue
        can :create, TicketGroup
        can :create, Artist
        can :edit, Artist
      if user.role? :admin
        can :manage, :all
        can :see_timestamps, :all
      elsif user.role? :moderator
        #can :manage, [Bibs, Questions]
        can :manage, User, :id=>user.id
        can :see_timestamps, User, :id=>user.id
        
      elsif user.role? :basic 
        can :manage, User do |u|
          u.try(:user) == user
        end
        can :create, Event
        can :edit, Event
        can :manage, Event do |event|
          event.try(:user) == user
        end
        can :create, Ticket
        can :manage, Ticket do |ticket|
          ticket.try(:user) == user
        end
        can :create, Sale 
        can :manage, Invoice do |invoice|
          invoice.try(:user) == user
        end
        can :manage, TicketGroup
        can :create, Marketplace
        can :manage, Commission do |c|
          c.try(:user) == user
        end
        can :see_timestamps, User, :id => user.id
      end
      if user.role? :venue
        can :manage, Venue
      end
    end
end
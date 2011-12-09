class CreateMyTicketGroups < ActiveRecord::Migration
  def self.up
    create_table :my_ticket_groups do |t|
      t.belongs_to :user
      t.integer :quantity
      t.belongs_to :ticket_group
      t.timestamps
    end
    add_index(:my_ticket_groups, [:ticket_group_id, :user_id])
    
  end

  def self.down
    drop_table :my_ticket_groups
  end
end

class AddUsersAndGroups < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.boolean :active
      t.timestamps
    end
    
    create_table :groups do |g|
      g.string :name
      g.integer :rank, :default => 5
      g.timestamps
    end
  end

  def self.down
    drop_table :groups
    drop_table :users
  end
end

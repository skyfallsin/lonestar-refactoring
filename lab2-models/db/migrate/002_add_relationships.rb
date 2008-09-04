class AddRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.references :user
      t.references :group
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end

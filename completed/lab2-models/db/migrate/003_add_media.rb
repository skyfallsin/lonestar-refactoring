class AddMedia < ActiveRecord::Migration
  def self.up
    create_table :audioclips do |t|
      t.references :user
      t.references :group
      t.string :title
      t.timestamps
    end
    
    create_table :videoclips do |t|
      t.references :user
      t.references :group
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :videoclips
    drop_table :audioclips
  end
end

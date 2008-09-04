class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :text
      t.references :link
      t.timestamps
    end
  end

  def self.down
    remove_table :tags
  end
end

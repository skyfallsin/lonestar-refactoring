class AddLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :name
      t.text   :url
      t.text   :curl
      t.timestamps
    end
  end

  def self.down
    remove_table :links
  end
end

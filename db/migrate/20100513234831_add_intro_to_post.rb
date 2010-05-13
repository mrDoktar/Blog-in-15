class AddIntroToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :intro, :text
  end

  def self.down
    remove_column :posts, :intro
  end
end

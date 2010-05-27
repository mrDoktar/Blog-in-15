class AddReviewedToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :reviewed, :boolean, :default => false
  end

  def self.down
    remove_column :posts, :reviewed
  end
end

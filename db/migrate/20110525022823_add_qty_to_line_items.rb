class AddQtyToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :qty, :integer, :default => 1
  end

  def self.down
    remove_column :line_items, :qty
  end
end

class AddTimestampsToCommentsAndCategories < ActiveRecord::Migration
  def change
    add_column :comments, :created_at, :datetime
    add_column :comments, :updated_at, :datetime
    add_column :categories, :created_at, :datetime
    add_column :categories, :updated_at, :datetime
  end
end

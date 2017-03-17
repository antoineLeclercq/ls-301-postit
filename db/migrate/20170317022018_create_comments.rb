class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
    end

    add_reference :comments, :user
    add_reference :comments, :post
  end
end

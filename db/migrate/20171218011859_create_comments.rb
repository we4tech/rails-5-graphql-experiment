class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.belongs_to :post, null: false

      t.timestamps null: false
    end
  end
end

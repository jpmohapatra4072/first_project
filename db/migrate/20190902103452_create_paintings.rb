class CreatePaintings < ActiveRecord::Migration[5.2]
  def change
    create_table :paintings do |t|
      t.string :name
      t.belongs_to :user
      t.attachment :painting
      t.timestamps
    end
  end
end

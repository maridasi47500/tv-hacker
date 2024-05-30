class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :filename
      t.string :link
      t.string :image
      t.integer :tv_id

      t.timestamps
    end
  end
end

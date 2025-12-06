class CreateTvstreams < ActiveRecord::Migration[7.1]
  def change
    create_table :tvstreams do |t|
      t.string :name
      t.string :firsttv
      t.string :mytv
      t.integer :tv_id

      t.timestamps
    end
  end
end

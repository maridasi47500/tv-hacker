class CreateTvs < ActiveRecord::Migration[7.1]
  def change
    create_table :tvs do |t|
      t.string :name
      t.string :rss
      t.string :lien

      t.timestamps
    end
  end
end

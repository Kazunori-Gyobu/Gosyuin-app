class CreateStamps < ActiveRecord::Migration[5.2]
  def change
    create_table :stamps do |t|
      t.string :name
      t.date :given_date
      t.string :photo
      t.text :remarks
      t.string :distinction
      t.references :stampbook, foreign_key: true

      t.timestamps
    end
  end
end

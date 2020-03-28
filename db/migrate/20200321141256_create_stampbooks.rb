class CreateStampbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :stampbooks do |t|
      t.string :name
      t.date :given_date
      t.string :cover
      t.text :remarks
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

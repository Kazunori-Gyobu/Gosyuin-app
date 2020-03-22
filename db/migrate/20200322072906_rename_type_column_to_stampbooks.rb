class RenameTypeColumnToStampbooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :stampbooks, :type, :distinction
  end
end

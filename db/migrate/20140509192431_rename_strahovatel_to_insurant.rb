class RenameStrahovatelToInsurant < ActiveRecord::Migration
  def change
    rename_column :contracts, :strahovatel_id, :insurant_id
  end
end

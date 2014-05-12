class RenameZastrahovanniyToInsured < ActiveRecord::Migration
  def change
    rename_column :contracts, :zastrahovanniy_id, :insured_id
  end
end

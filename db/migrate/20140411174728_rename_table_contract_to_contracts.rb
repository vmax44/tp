class RenameTableContractToContracts < ActiveRecord::Migration
  def change
    rename_table('contract','contracts')
  end
end

class RenameTablePolis < ActiveRecord::Migration
  def change
    rename_table('polis','policy')
  end
end

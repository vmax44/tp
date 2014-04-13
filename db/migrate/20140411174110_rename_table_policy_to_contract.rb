class RenameTablePolicyToContract < ActiveRecord::Migration
  def change
    rename_table('policy','contract')
  end
end

class RenameStrahovatelToPerson < ActiveRecord::Migration
  def change
    rename_table('strahovatels','persons')
  end
end

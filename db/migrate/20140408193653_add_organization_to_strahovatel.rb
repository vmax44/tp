class AddOrganizationToStrahovatel < ActiveRecord::Migration
  def change
    add_column :strahovatels, :organization_id, :integer
  end
end

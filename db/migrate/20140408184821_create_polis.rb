class CreatePolis < ActiveRecord::Migration
  def change
    create_table :polis do |t|
      t.integer :agent_id
      t.integer :strahovatel_id
      t.integer :zastrahovanniy_id
      t.string :number
      t.date :date
      t.date :datestart
      t.date :datefinish
      t.integer :cost
      
      t.timestamps
    end
  end
end

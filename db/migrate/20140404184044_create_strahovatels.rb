class CreateStrahovatels < ActiveRecord::Migration
  def change
    create_table :strahovatels do |t|
      t.string :lastname
      t.string :firstname
      t.string :address
      t.string :passport
      
      t.timestamps
    end
  end
end

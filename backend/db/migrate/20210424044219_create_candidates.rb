class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :city, null: false
      t.string :experience, null: false
 
      t.timestamps
    end
  end
end

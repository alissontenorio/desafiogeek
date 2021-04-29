class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :city, null: false
      t.string :state, null: false
      t.integer :years_experience, null: false
 
      t.timestamps
    end
  end
end

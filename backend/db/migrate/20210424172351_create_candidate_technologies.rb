class CreateCandidateTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_technologies do |t|
      t.references :candidate, foreign_key: true, null: false
      t.string :name, null: false
      t.boolean :is_main_tech, null: false
      
      t.timestamps
    end
  end
end

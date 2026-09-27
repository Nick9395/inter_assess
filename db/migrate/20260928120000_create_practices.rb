class CreatePractices < ActiveRecord::Migration[8.1]
  def change
    create_table :practices do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :question_count, null: false
      t.string :status, null: false, default: "in_progress"
      t.timestamps
    end

    add_index :practices, [ :user_id, :status ]

    create_table :turns do |t|
      t.references :practice, null: false, foreign_key: true
      t.string :kind, null: false, default: "master"
      t.integer :sequence, null: false
      t.string :master_key
      t.text :question_text, null: false
      t.text :answer_text
      t.timestamps
    end

    add_index :turns, [ :practice_id, :sequence ], unique: true
  end
end

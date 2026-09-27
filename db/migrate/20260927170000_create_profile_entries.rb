class CreateProfileEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :education_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :enrolled_on, null: false
      t.string :school_name, null: false
      t.string :faculty
      t.date :graduated_on
      t.text :learned
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :education_entries, [ :user_id, :position ]

    create_table :work_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :joined_on, null: false
      t.date :left_on
      t.text :company_description, null: false
      t.string :role
      t.text :achievement
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :work_entries, [ :user_id, :position ]
  end
end

class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.integer :question_type
      t.text :text
      t.jsonb :options, default: {}
      t.boolean :required, default: false
      t.integer :order

      t.timestamps
    end
  end
end

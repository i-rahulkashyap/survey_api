class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :response, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :text_value
      t.string :file_url

      t.timestamps
    end
  end
end

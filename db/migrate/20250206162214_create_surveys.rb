class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :theme

      t.timestamps
    end
  end
end

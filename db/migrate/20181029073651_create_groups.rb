class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.references :user
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end

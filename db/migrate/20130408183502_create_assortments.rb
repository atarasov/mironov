class CreateAssortments < ActiveRecord::Migration
  def change
    create_table :assortments do |t|
      t.string :name
      t.integer :old_id
      t.integer :level

      t.timestamps
    end
  end
end

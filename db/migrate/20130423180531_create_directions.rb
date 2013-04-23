class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :name
      t.integer :old_id

      t.timestamps
    end
  end
end

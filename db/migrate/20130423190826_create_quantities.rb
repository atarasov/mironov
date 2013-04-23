class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.integer :kol
      t.date :date

      t.timestamps
    end
  end
end

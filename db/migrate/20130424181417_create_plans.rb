class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.float :day
      t.float :month
      t.date :date
      t.references :assortment

      t.timestamps
    end
    add_index :plans, :assortment_id
  end
end

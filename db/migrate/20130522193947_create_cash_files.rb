class CreateCashFiles < ActiveRecord::Migration
  def change
    create_table :cash_files do |t|

      t.attachment :cash
      t.attachment :cashc
      t.attachment :balance

      t.timestamps
    end
  end
end

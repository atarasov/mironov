class CreateAdminMains < ActiveRecord::Migration
  def change
    create_table :admin_mains do |t|

      t.timestamps
    end
  end
end

class CreateDbfFiles < ActiveRecord::Migration
  def change
    create_table :dbf_files do |t|

      t.attachment :plan
      t.attachment :implementation

      t.timestamps
    end
  end
end

class Balance < ActiveRecord::Base
  self.table_name = 'TARX'
  attr_accessible :DATA, :DAT, :RSUM, :S, :NAMEPO, :NAZN
end
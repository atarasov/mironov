class Cashc < ActiveRecord::Base
  self.table_name = 'KC'
  attr_accessible :N, :DAT, :KOD, :NAIM, :SUM, :BN1, :BN2, :BN3, :BN4, :BN5, :AWT, :BK1, :BK2, :BK3, :BK4, :BK5
end
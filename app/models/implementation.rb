class Implementation < ActiveRecord::Base
  self.table_name = 'RL'
  attr_accessible :S, :N, :DAT, :DN, :KOD, :NAIM, :SUM, :SUMM, :SUMY, :P, :AWT
  #field :KOD
  #field :NAIM
  #field :SUM
  #field :SUMM
  #field :SUMY
  #field :DAT

end
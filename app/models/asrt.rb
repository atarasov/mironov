class Asrt < ActiveRecord::Base
  self.table_name = 'PL'
  attr_accessible :C, :DAT, :N, :KOD, :NAIM, :DN, :PLM, :PLS, :PLD, :VRY,
                  :VRS, :VRD, :OST, :OST1, :RLD, :NSS, :A1, :A2, :A3, :A4, :A5, :A6, :A7, :A8, :A9, :P, :AWT
end
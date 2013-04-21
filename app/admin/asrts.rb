# encoding: utf-8
ActiveAdmin.register Asrt do
  index do
    column :C
    column :DAT
    column :N
    column :KOD
    column :NAIM
    column :DN
    column :PLM
    column :PLS
    column :PLD
    column :VRY
    column :VRS
    column :VRD
    column :OST
    column :OST1
    column :RLD
    column :NSS
    column :A1
    column :A2
    column :A3
    column :A4
    column :A5
    column :A6
    column :A7
    column :A8
    column :A9
    column :P
    column :AWT

    default_actions
  end

  filter :N
  filter :KOD
  filter :NAIM
  filter :DN


  form do |f|
    f.inputs "План" do
      f.input :C
      f.input :DAT
      f.input :N
      f.input :KOD
      f.input :NAIM
      f.input :DN
      f.input :PLM
      f.input :PLS
      f.input :PLD
      f.input :VRY
      f.input :VRS
      f.input :VRD
      f.input :OST
      f.input :OST1
      f.input :RLD
      f.input :NSS
      f.input :A1
      f.input :A2
      f.input :A3
      f.input :A4
      f.input :A5
      f.input :A6
      f.input :A7
      f.input :A8
      f.input :A9
      f.input :P
      f.input :AWT
    end
    f.actions
  end

end

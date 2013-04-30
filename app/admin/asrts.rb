# encoding: utf-8
ActiveAdmin.register Asrt, {:sort_order => "N ASC"} do

  scope :all

  scope :today, :default => true do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year).order('N ASC')
  end

  scope :day2 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 1.day).day, (Time.now - 1.day).month, (Time.now - 1.day).year).order('N ASC')
  end

  scope :day3 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 2.day).day, (Time.now - 2.day).month, (Time.now - 2.day).year).order('N ASC')
  end

  scope :day4 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 3.day).day, (Time.now - 3.day).month, (Time.now - 3.day).year).order('N ASC')
  end

  scope :day5 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 4.day).day, (Time.now - 4.day).month, (Time.now - 4.day).year).order('N ASC')
  end

  scope :day6 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 5.day).day, (Time.now - 5.day).month, (Time.now - 5.day).year).order('N ASC')
  end

  scope :day7 do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", (Time.now - 6.day).day, (Time.now - 6.day).month, (Time.now - 6.day).year).order('N ASC')
  end

  sidebar :plan_create

  index do
    selectable_column
    column :N
    #column :C
    column :DAT
    #column :KOD
    column :NAIM
    #column :DN
    column :PLM
    column :PLS
    column :PLD
    #column(:PLD) { |i| best_in_place i, :PLD, :type => :input, :path => [:admin, i] }
    #column :VRY
    column :VRS
    #column :VRD
    column(:VRD) { |i| best_in_place i, :VRD, :type => :input, :path => [:admin, i] }
    #column :OST
    column(:OST) { |i| best_in_place i, :OST, :type => :input, :path => [:admin, i] }
    #column :OST1
    #column :RLD
    column(:RLD) { |i| best_in_place i, :RLD, :type => :input, :path => [:admin, i] }
    #column :NSS
    #column :A1
    #column :A2
    #column :A3
    #column :A4
    #column :A5
    #column :A6
    #column :A7
    #column :A8
    #column :A9
    #column :P
    #column :AWT
    if current_admin_user.super_admin?
      default_actions
    end
  end

  filter :N
  filter :DAT
  filter :NAIM
  filter :DN


  form do |f|
    f.inputs "План" do
      f.input :C
      f.input :NAIM, :as => :select, :collection => Assortment.all
      f.input :DAT, :as => :datepicker
      f.input :N
      f.input :KOD

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
      #f.input :NSS
      #f.input :A1
      #f.input :A2
      #f.input :A3
      #f.input :A4
      #f.input :A5
      #f.input :A6
      #f.input :A7
      #f.input :A8
      #f.input :A9
      #f.input :P
      #f.input :AWT
    end
    f.actions
  end


  before_save do |asrt|
    #asrt.N = params[:implementation][:NAIM]
    #asrt.NAIM = Direction.find(params[:implementation][:NAIM]).name
    #asrt.DN = params[:implementation][:DAT].to_date.day

    if (params[:asrt] && params[:asrt][:DAT] && params[:asrt][:DAT].to_date.day ==  1) || asrt.DAT.to_date.day ==  1
      asrt.VRS = params[:asrt][:VRS]
      asrt.PLS = params[:asrt][:PLD]
    else
      date = params[:asrt][:DAT]? params[:asrt][:DAT].to_date : asrt.DAT.to_date
      #sum = params[:asrts][:PLD].to_f || asrt.PLD.to_f
      sumvrd = params[:asrt][:VRD]? params[:asrt][:VRD].to_f : asrt.VRD.to_f
      naim = params[:asrt][:NAIM] || asrt.N
      asrt.PLS = Asrt.where("DATE(DAT) = ? AND N = ?", date - 1.day, naim).first.PLS.to_f + asrt.PLD.to_f
      asrt.VRS = Asrt.where("DATE(DAT) = ? AND N = ?", date - 1.day, naim).first.VRS.to_f + sumvrd
    end
  end

end

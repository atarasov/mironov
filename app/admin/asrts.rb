# encoding: utf-8
ActiveAdmin.register Asrt do

  scope :all

  scope :today, :default => true do |asrts|
    asrts.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", Time.now.day, Time.now.month, Time.now.year)
  end


  index do
    #column :C
    column :DAT
    #column :N
    #column :KOD
    column :NAIM
    #column :DN
    column :PLM
    column :PLS
    #column :PLD
    column(:PLD) { |i| best_in_place i, :PLD, :type => :input, :path => [:admin, i] }
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

  #controller do
  #  def scoped_collection
  #    Asrt.where("DAT = ?", Time.now.to_date) #if params[:q].blank?
  #  end
  #end

  #collection_action :index, :method => :get do
  #  # Only get the items belonging to a group owned by the current user
  #  scope = Asrt.where("DAT = ?", Time.now.to_date - 1.year)
  #
  #  @collection = scope.page(params[:page]).per(10)
  #
  #  respond_to do |format|
  #    format.html {
  #      render "active_admin/resource/index"
  #    }
  #  end
  #end

  filter :N
  filter :DAT
  filter :NAIM
  filter :DN


  form do |f|
    f.inputs "План" do
      #f.input :C
      f.input :NAIM, :as => :select, :collection => Assortment.all
      f.input :DAT, :as => :datepicker
      #f.input :N
      #f.input :KOD

      #f.input :DN
      #f.input :PLM
      #f.input :PLS
      f.input :PLD
      #f.input :VRY
      #f.input :VRS
      f.input :VRD
      f.input :OST
      #f.input :OST1
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

  end

end

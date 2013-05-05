#include BestInPlace::BestInPlaceHelpers
class ApplicationController < ActionController::Base
  include BestInPlace
  #before_filter :sum_cor, :only => :index
  #before_filter :implementation_create, :only => :index
  protect_from_forgery


  def sum_cor
    Direction.all.each do |assortment|
      summ = Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) <= ? AND N = ?",assortment.DAT.year, assortment.DAT.month, assortment.DAT.day, assortment.old_id).sum("SUM")
      sumy = Implementation.where("YEAR(DAT) = ? AND DAY(DAT) <= ? AND N = ?",assortment.DAT.year, assortment.DAT.day, assortment.old_id).sum("SUM")
      Implementation.where("YEAR(DAT) = ? AND MONTH(DAT) = ? AND DAY(DAT) = ? AND N = ?",assortment.DAT.to_date.year, assortment.DAT.to_date.month, assortment.DAT.to_date.day, assortment.old_id).update_all(:SUMY => sumy, :SUMM => summ )
    end

  end

  def plan_create
    if params[:scope] && params[:scope] != 'today'
      @day = Time.now - (params[:scope].split('day')[1].to_i - 1).day
    elsif params[:scope] == 'today'
      @day = Time.now
    else
      @day = Time.now - 1.day
    end
    @asrt = Asrt.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", @day.day, @day.month, @day.year)
    if @asrt && @asrt.size == 0
      @plan = Plan.where("MONTH(date) = ? AND YEAR(date) = ?",Time.now.month, Time.now.year)
      Assortment.all.each do |assortment|
        #raise @plan.inspect
        if @plan && @plan.size == 0
          Assortment.all.each do |assort|
            Plan.create({:assortment_id => assort.id, :date => Time.now.end_of_month.to_date})
          end
          @plan2 = Plan.where("MONTH(date) = ? AND YEAR(date) = ?",Time.now.month, Time.now.year)
          if @plan2 && @plan.size != 0
          Asrt.create({:NAIM => assortment.name,
                       :DN =>@day.day,
                       :PLD =>  @plan2.where(:assortment_id => assortment.id).first.day,
                       :PLM =>  @plan2.where(:assortment_id => assortment.id).first.month,
                       :N => assortment.old_id,
                       :DAT => @day})  if @plan.where(:assortment_id => assortment.id).first
          end
          #Asrt.create({:NAIM => assort.name,:DN =>Time.now.day, :N => assort.id, :DAT => Time.now})
        else
          Asrt.create({:NAIM => assortment.name,
                       :DN =>@day.day,
                       :PLD =>  @plan.where(:assortment_id => assortment.id).first.day,
                       :PLM =>  @plan.where(:assortment_id => assortment.id).first.month,
                       :N => assortment.old_id,
                       :DAT => @day})  if @plan.where(:assortment_id => assortment.id).first
        end
        #
      end
      flash.keep[:notice]="План успешно создан!"
      redirect_to admin_asrts_url
    else
      flash.keep[:error]="План уже создан!"
      redirect_to admin_asrts_url
    end

  end
  def implementation_create
    if params[:scope] && params[:scope] != 'today'
      @day = Time.now - (params[:scope].split('day')[1].to_i - 1).day
    elsif params[:scope] == 'today'
      @day = Time.now
    else
      @day = Time.now - 1.day
    end
    @impl = Implementation.where("DAY(DAT) = ? AND MONTH(DAT) = ? AND YEAR(DAT) = ?", @day.day, @day.month, @day.year)
    if @impl && @impl.size == 0
      Direction.all.each do |direction|
        Implementation.create({:NAIM => direction.name,:DN =>@day.day, :N => direction.old_id, :DAT => @day})
      end
      flash.keep[:notice]="Реализация успешно созданна!"
      redirect_to admin_implementations_url
    else
      flash.keep[:error]="Реализация уже созданна!"
      redirect_to admin_implementations_url
    end


  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      conference_path
    elsif resource_or_scope.is_a?(AdminUser)
      admin_assortments_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_assortments_path, :alert => exception.message
  end
end

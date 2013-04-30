class Plan < ActiveRecord::Base
  #default_scope :order => :old_id

  belongs_to :assortment
  attr_accessible :date, :day, :month, :assortment_id, :assortment
end

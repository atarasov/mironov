class Plan < ActiveRecord::Base
  belongs_to :assortment
  attr_accessible :date, :day, :month, :assortment_id
end

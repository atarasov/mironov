class Assortment < ActiveRecord::Base
  attr_accessible :name, :old_id
  has_many :plans
end

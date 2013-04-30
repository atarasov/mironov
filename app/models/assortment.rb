class Assortment < ActiveRecord::Base
  default_scope :order => :old_id
  attr_accessible :name, :old_id
  has_many :plans
end

class Supplier < ActiveRecord::Base
  attr_accessible :address, :comment, :company, :contactor, :email, :fax, :phone
  has_one :repository
end

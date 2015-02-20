class Batch < ActiveRecord::Base
	before_destroy :undo
  has_many :manipulations

  def undo
  	self.manipulations.each do |manipulation|
  		manipulation.destroy
  	end
	end

end

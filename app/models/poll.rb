class Poll < ActiveRecord::Base

  validates :title, :author, :presence => true

end

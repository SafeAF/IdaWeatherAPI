require "active_record"

class Historical < ActiveRecord::Base
    validates :time_index, uniqueness: true
end
   
   
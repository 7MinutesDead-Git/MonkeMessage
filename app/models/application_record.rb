# https://guides.rubyonrails.org/active_record_basics.html
require 'obscenity/active_model'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

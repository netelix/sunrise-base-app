class ApplicationRecord < ActiveRecord::Base
  include Sunrise::Models::Fixtureable

  self.abstract_class = true
end

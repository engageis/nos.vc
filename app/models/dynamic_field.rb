class DynamicField < ActiveRecord::Base
  belongs_to :project
  attr_accessible :input_name, :input_value, :required
  validates :input_name, presence: true
end

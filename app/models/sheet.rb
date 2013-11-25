class Sheet < ActiveRecord::Base
end

# == Schema Information
#
# Table name: sheets
#
#  id            :integer         not null, primary key
#  student_id    :integer
#  experiment_id :integer
#  marker_id     :integer
#  comments      :text
#  raw_mark      :integer
#  created_at    :datetime
#  updated_at    :datetime
#


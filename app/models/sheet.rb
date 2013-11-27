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

class Sheet < ActiveRecord::Base

  attr_accessible :student_id, :experiment_id, :marker_id, :comments, :raw_mark, :ret_mark

  belongs_to :student
  belongs_to :experiment
  belongs_to :marker

  validates :raw_mark, numericality: {only_integer: true}
  validates :raw_mark, numericality: {less_than_or_equal_to: 100}
  validates :raw_mark, numericality: {greater_than_or_equal_to: 0}
  validates :student_id, :uniqueness => {:scope => :experiment_id,
            :message => "already has a mark sheet for this experiment."}


  def return_mark
    return_mark = raw_mark * marker.scaling + marker.shift
    return_mark > 100 ? 100 : return_mark
  end


end

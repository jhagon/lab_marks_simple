# == Schema Information
#
# Table name: students
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Student < ActiveRecord::Base

  attr_accessible :number, :first, :last, :email

  has_many :sheets

  def name
    self.last + ',  ' + self.first
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create! row.to_hash
    end
  end

end

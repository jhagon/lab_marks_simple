class Marker < ActiveRecord::Base
end

# == Schema Information
#
# Table name: markers
#
#  id                 :integer         not null, primary key
#  first              :string(255)
#  last               :string(255)
#  email              :string(255)
#  abbr               :string(255)
#  scaling            :float           default(1.0)
#  shift              :float           default(0.0)
#  admin              :boolean         default(FALSE)
#  encrypted_password :string(255)
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#


class Gallery < ActiveRecord::Base

  belongs_to :user
  has_many :pictures

  validates :user, presence: true

end

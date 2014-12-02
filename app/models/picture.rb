class Picture < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery
  has_many :snapshots, dependent: :destroy
  has_one :current_version, class_name: "Snapshot"

  validates :user, :gallery, presence: true

end

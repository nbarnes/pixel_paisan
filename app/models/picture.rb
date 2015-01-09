class Picture < ActiveRecord::Base

  belongs_to :user
  belongs_to :gallery
  has_many :snapshots, dependent: :destroy

  validates :user, :gallery, presence: true

  def current_version
    return snapshots.max do |a, b|
      a.created_at <=> b.created_at
    end
  end

end

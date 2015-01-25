
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

  def as_json
    snapshot = current_version
    json = Hash.new
    json[:picture_name] = name
    json[:cell_size] = snapshot.cell_size
    json[:picture_id] = id
    json[:image_data] = snapshot.image_data_json
    return json
  end

  def copy_for_branch(current_user)
    pic = Picture.create
    pic.name = name
    pic.gallery = current_user.galleries[0]
    pic.user = current_user
    new_snapshot = current_version.copy_for_branch()
    new_snapshot.picture_id = pic.id
    pic.current_version = new_snapshot
    pic.save!
    return pic
  end

end

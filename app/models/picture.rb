
class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery
  has_many :snapshots

  validates :user, :gallery, presence: true
  validates_format_of :name, with: /\A[a-z0-9_]+\z/i

  scope :created_between, -> (start_date, end_date) { where(created_at: start_date..end_date) }

  def current_version
    return snapshots.max do |a, b|
      a.created_at <=> b.created_at
    end
  end

  def editor_json
    snapshot = current_version
    json = {}
    json[:picture_name] = name
    json[:cell_size] = snapshot.cell_size
    json[:picture_id] = id
    json[:image_data] = snapshot.image_json
    json[:palette_id] = palette_id
    return json
  end

  def branch(current_user)
    pic = Picture.create
    pic.name = name
    pic.user = current_user
    pic.gallery = current_user.galleries[0]
    new_snapshot = current_version.branch
    new_snapshot.picture_id = pic.id
    pic.current_version = new_snapshot
    pic.save!
    return pic
  end

  def add_snapshot(params)
    snapshot = Snapshot.new(pixels: params[:pixels], cell_size: params[:cell_size], picture: self)
    snapshot.save!
  end

end

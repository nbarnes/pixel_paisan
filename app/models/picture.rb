
class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :gallery
  has_many :snapshots

  validates :user, :gallery, presence: true
  validates_format_of :name, with: /\A[a-z0-9_]+\z/i

  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  def current_version
    return snapshots.max_by(&:created_at)
  end

  def editor_json
    snapshot = current_version
    json = {}
    json[:picture_name] = name
    json[:cell_size] = snapshot.cell_size
    json[:picture_id] = id
    json[:pixels] = snapshot.pixels
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
    # rubocop:disable Style/GuardClause
    unless current_version && pixels_same(params[:pixels], current_version.pixels)
      snapshot = snapshots.build(pixels: params[:pixels], cell_size: params[:cell_size])
    end
    # rubocop:enable Style/GuardClause
  end

  def pixels_same(foo, bar)
   return false unless (foo.size == bar.size)
    foo.each_with_index do |row, x|
      row.each_with_index do |_column, y|
        return false unless pixel_equal(foo[x][y], bar[x][y])
      end
    end
    return true
  end

  def pixel_equal(x, y)
    { r: x['r'].to_i, g: x['g'].to_i, b: x['b'].to_i, a: x['a'].to_i } ==
      { r: y['r'].to_i, g: y['g'].to_i, b: y['b'].to_i, a: y['a'].to_i }
  end

end

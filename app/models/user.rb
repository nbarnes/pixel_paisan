class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :palettes
  has_many :pictures
  has_many :galleries

  validates :name, uniqueness: { case_sensitive: false }

  after_create :create_galleries

  scope :created_between, ->(start_date, end_date) { where(created_at: start_date..end_date) }

  def create_galleries
    galleries.create
  end

  def admin?
    return role == 'admin'
  end

  def display_name
    return name.blank? ? email : name
  end

end

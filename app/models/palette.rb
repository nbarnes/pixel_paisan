class Palette < ActiveRecord::Base

  belongs_to :user

  validates :name, :user, presence: true

  def initialize(opts = {})
    super opts
    self.colors = []
  end

end

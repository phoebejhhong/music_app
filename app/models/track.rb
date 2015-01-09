class Track < ActiveRecord::Base
  KINDS = ['regular', 'bonus']
  validates :name, :album_id, :kind, presence: true
  validates :kind, inclusion: { in: KINDS }
  belongs_to :album
  has_one :band, through: :album

end

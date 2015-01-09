class Album < ActiveRecord::Base
  KINDS = [ "studio", "live"]
  validates :name, :band_id, presence: true
  validates :kind, presence: true, inclusion: { in: KINDS }

  belongs_to :band
  has_many :tracks, dependent: :destroy

end

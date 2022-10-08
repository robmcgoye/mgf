class Gallery < ApplicationRecord
  extend Mobility
  translates :title, type: :string

  visitable :ahoy_visit
  mount_uploader :thumbnail, ImagesUploader 

  has_many :photos
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :title, presence: true, length: { minimum: 1, maximum: 125 } 
  validates :thumbnail, presence: true, on: :create
  validates :sort_order, numericality: true
  
  default_scope { order(sort_order: :asc) }

end

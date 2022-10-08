class Event < ApplicationRecord
  extend Mobility
  translates :title, type: :string
  translates :body, type: :text
  
  visitable :ahoy_visit

  mount_uploader :thumbnail, ImagesUploader 
  
  validates :title, presence: true, length: { minimum: 1, maximum: 125 }  
  validates :thumbnail, presence: true, on: :create
  validates :event_date, presence: true
  validates :body, presence: true

  default_scope { order(event_date: :desc) }

end

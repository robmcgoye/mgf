class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true


  # scope :created_between, -> {|start_date, end_date| where("started_at >= ? AND started_at <= ?", start_date, end_date )}
  scope :days_to_get, ->(number_of_days) { where(started_at: number_of_days.days.ago..) }

end

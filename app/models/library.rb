class Library < ApplicationRecord
  extend Mobility
  translates :title, type: :string
  translates :body, type: :text

  visitable :ahoy_visit
  
  has_many :subtitles
  accepts_nested_attributes_for :subtitles, allow_destroy: true
  
  validates :title, presence: true, length: { minimum: 1, maximum: 125 }  
  validates :link, http_url: true, if: :action_is_link?
  validates :body, presence: true, if: :action_is_page?
  validates :sort_order, numericality: true
  
  after_initialize :set_defaults

  default_scope { order(sort_order: :asc) }

  ACTIONS = [:link, :page, :none]

  def self.options
    ACTIONS.map( &:to_s )
  end

  def action_is_link?
    action == 'link'
  end

  def action_is_page?
    action == 'page'
  end

  def set_defaults
    self.action ||= 'none'
  end
end

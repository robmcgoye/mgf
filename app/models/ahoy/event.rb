class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods

  self.table_name = "ahoy_events"

  belongs_to :visit
  belongs_to :user, optional: true

  serialize :properties, JSON

  # scope :created_between, lambda {|start_date, end_date| where("started_at >= ? AND started_at <= ?", start_date, end_date )}
  scope :days_to_get, ->(number_of_days) { where(time: number_of_days.days.ago..) }

  def self.page_requests (number_of_days, language)
    requests = {}
    all_requests = Ahoy::Event.days_to_get(number_of_days)
    all_requests.each do |r|
      if r.properties["controller"].nil? ||  r.properties["controller"] == "analytics" ||  
          r.properties["controller"] =="sessions"
      else
        if r.properties["action"] == "edit" || r.properties["action"] == "update" || 
            r.properties["action"] == "create"
        else

          if !r.properties.key?("locale")
            current_language = "en"
          else
            if r.properties["locale"] == "en"
              current_language = "en"
            else
              current_language = "es"
            end
          end

          if current_language == language
           current_controller_action = "#{r.properties["controller"]}_#{r.properties["action"]}"
            if current_controller_action != "pages_show" && 
                current_controller_action != "events_new" && 
                current_controller_action != "galleries_new" &&
                current_controller_action != "libraries_new"
            
              if current_controller_action == "pages_home"
                current_controller_action = "Home"
              elsif current_controller_action == "contact_forms_new"
                current_controller_action = "Contact Us"
              elsif current_controller_action == "libraries_index"            
                current_controller_action = "Library Home"
              elsif current_controller_action == "events_index"            
               current_controller_action = "Events Home"
              elsif current_controller_action == "galleries_index"            
                current_controller_action = "Galleries Home"
              elsif current_controller_action == "pages_photographer_1"            
                current_controller_action = "Alfredo Pastor"
              elsif current_controller_action == "pages_photographer_2"            
                current_controller_action = "James Phillips"
              elsif current_controller_action == "pages_photographer_3"            
                current_controller_action = "Carolyn Stutt"
              elsif current_controller_action == "pages_mission"            
                current_controller_action = "About Us Mission"
              elsif current_controller_action == "pages_philosophy"            
                current_controller_action = "About Us Philosophy"
              elsif current_controller_action == "pages_about"
                current_controller_action = "About Us"
              elsif current_controller_action == "pages_history"
                current_controller_action = "About Us History"
              elsif current_controller_action == "pages_links"
                current_controller_action = "Links"
              elsif current_controller_action == "galleries_show"
                current_controller_action = "Gallery {#{r.properties["id"]}} #{ Gallery.get_title(r.properties["id"]) }"
              elsif current_controller_action == "events_show"
                current_controller_action = "Event {#{r.properties["id"]}} #{ Event.get_title(r.properties["id"]) }"
              elsif current_controller_action == "libraries_show"
                current_controller_action = "Library {#{r.properties["id"]}} #{ Library.get_title(r.properties["id"]) }"
              end
              if !requests.key?(current_controller_action)
                requests[current_controller_action] = 1
              else
                requests[current_controller_action] += 1
              end
            end
          end
        end
      end
    end
    requests
  end

end

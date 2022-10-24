class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_user, only: [:new, :edit, :update, :destroy]
  after_action :track_action, except: [:edit, :update, :destroy] 
  
  def index
    if admin_user?
      @pagy, @events = pagy(Event.all, items: 6)
    else
      @pagy, @events = pagy(Event.where(published: true), items: 6)
    end
  end

  def show
    if !admin_user? && !@event.published
      redirect_to events_url
    end
  end
    
  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = I18n.t("event.created")
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = I18n.t("event.updated")
      redirect_to event_url(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = I18n.t("event.deleted")
    redirect_to events_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :thumbnail, :event_date, :body, :published)
    end
end

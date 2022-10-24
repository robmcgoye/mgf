class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_user, only: [:new, :edit, :update, :destroy]
  after_action :track_action, except: [:edit, :update, :destroy] 
  
  def index
    if admin_user?
      @pagy, @galleries = pagy(Gallery.all, items: 6)
    else
      @pagy, @galleries = pagy(Gallery.where(published: true), items: 6)
    end
  end

  def show
    if !admin_user? && !@gallery.published
      redirect_to galleries_url
    end
  end
    
  def new
    @gallery = Gallery.new
  end

  def edit
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      flash[:notice] = I18n.t("gallery.created")
      redirect_to gallery_url(@gallery)
    else
      render :new
    end
  end

  def update
    if @gallery.update(gallery_params)
      flash[:notice] = I18n.t("gallery.updated")
      redirect_to gallery_url(@gallery)
    else
      render :edit
    end
  end

  def destroy
    @gallery.destroy
    flash[:notice] = I18n.t("gallery.deleted")
    redirect_to galleries_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gallery_params
      params.require(:gallery).permit(:title, :thumbnail, :sort_order, :published, 
                    photos_attributes: [:id, :picture, :caption, :sort_order,:_destroy])
    end
end

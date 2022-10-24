class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_user, only: [:new, :edit, :update, :destroy]
  after_action :track_action, except: [:edit, :update, :destroy] 
    
  def index
    if admin_user?
      @pagy, @libraries = pagy(Library.all, items: 10)
    else
      @pagy, @libraries = pagy(Library.where(published: true), items: 10)
    end
  end

  def show
    if @library.action != "page"
      redirect_to libraries_url
    else
      if !admin_user? && !@library.published
        redirect_to libraries_url
      end
    end
  end
    
  def new
    @library = Library.new
  end

  def edit
  end

  def create
    @library = Library.new(library_params)
    if @library.save
      flash[:notice] = I18n.t("library.created")
      redirect_to library_url(@library)
    else
      render :new
    end
  end

  def update
    if @library.update(library_params)
      flash[:notice] = I18n.t("library.updated")
      redirect_to library_url(@library)
    else
      render :edit
    end
  end

  def destroy
    @library.destroy
    flash[:notice] = I18n.t("library.deleted")
    redirect_to libraries_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.require(:library).permit(:title, :action, :link, :thumbnail, :body, 
              :published, :sort_order, 
              subtitles_attributes: [:id, :title, :link, :sort_order, :thumbnail, :_destroy])
    end
end

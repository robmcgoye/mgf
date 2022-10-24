class PagesController < ApplicationController
  before_action :require_admin_user, only: [:edit, :update]
  before_action :set_page, only: [:edit, :update, :show]
  after_action :track_action, except: [:edit, :update]  
  
  def home
    @page = load_page(:home)
  end

  def about
    @page = load_page(:about)
  end
  
  def history
    @page = load_page(:history)
  end
  
  def mission
    @page = load_page(:mission)
  end

  def philosophy
    @page = load_page(:philosophy)
  end

  def links
    @page = load_page(:links)
  end

  def photographer_1
    @page = load_page(:photographer_1)
  end

  def photographer_2
    @page = load_page(:photographer_2)
  end

  def photographer_3
    @page = load_page(:photographer_3)
  end

  def edit
  end

  def show
    render @page.name
  end

  def update
    if @page.update(page_params)
      flash[:notice] = I18n.t("page.success")
      if @page.name == "contact"
        redirect_to new_contact_form_path
      else
        redirect_to url_for(@page)
      end
    else
      render :edit
    end
  end

  private
  
    def load_page(page_name)
      Page.find_by_name(page_name) || Page.create!(name: page_name, body: "CONTACT administrator. Newly created page: #{page_name}")
    end

    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:body)
    end
end

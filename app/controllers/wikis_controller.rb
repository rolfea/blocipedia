class WikisController < ApplicationController

  def user_wikis
    @wikis = current_user.own_wikis
  end

  def index
    @wikis = policy_scope(Wiki)
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])

    unless !@wiki.private || current_user.premium? || current_user.admin? || @wiki.users.include?(current_user)
      flash[:alert] = "You must upgrade to a premium account to view private wikis."
      redirect_to new_charge_path
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

end

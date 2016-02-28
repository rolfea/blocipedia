class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    user = User.where(email: params[:collaborator]).first
    # if user and no collaborator for that user and wiki, create a collaborator
    if user && !@wiki.users.include?(user)
      Collaborator.create(user: user, wiki: @wiki)
      flash[:success] = "#{user.email} was added as a collaborator."
    # if user and already collaborator, flash error and redirect_to wiki
    elsif @wiki.users.include?(user)
      flash[:alert] = "User is already a collaborator"
    elsif !user
      flash[:error] = "#{params[:collaborator]} must be a user to add as collaborator"
    # if !user, then flash error and redirect_to edit for wiki
    else
      flash[:error] = "Something went wrong. Try again, please."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
  end
end

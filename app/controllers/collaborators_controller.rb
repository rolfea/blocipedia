class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    user = User.where(email: params[:collaborator]).first

    if @wiki.users.include?(user)
      flash[:alert] = "#{user.email} is already a collaborator"
    elsif user == current_user
      flash[:error] = "You cannot add yourself as collaborator."
    elsif !user
      flash[:error] = "#{params[:collaborator]} must be a user to add as collaborator"
    elsif user && !@wiki.users.include?(user)
      Collaborator.create(user: user, wiki: @wiki)
      flash[:success] = "#{user.email} was added as a collaborator."
    else
      flash[:error] = "Something went wrong. Try again, please."
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.find(params[:id])
    user_id = collaborator.user_id


    if @wiki.collaborators.include?(collaborator)
      collaborator.delete
      flash[:success] = "#{User.find(user_id).email} has been removed."
    elsif !@wiki.collaborators.include?(collaborator)
      flash[:error] = "That user is not currently a collaborator. Please refresh the page."
    else
      flash[:error] = "Something went wrong. Try again, please."
    end

    redirect_to edit_wiki_path(@wiki)
  end
end

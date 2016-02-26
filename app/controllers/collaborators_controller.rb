class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.new(user_id: params[:collaborator], wiki_id: params[:wiki_id])
    puts params[:collaborator]

    if collaborator.save
      flash[:notice] = "Collaborator was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error adding the collaborator. Please try again."
      render :edit
    end
  end

  def destroy
  end
end

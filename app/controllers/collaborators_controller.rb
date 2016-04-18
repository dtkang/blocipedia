class CollaboratorsController < ApplicationController
    
    def destroy
        collaborator = Collaborator.find(params[:id])
        
        if collaborator.destroy
            flash[:success] = "Collaborator destroyed successfully"
        else
            flash[:error] = "Error while trying to destroy collaborator"
        end
        redirect_to wiki_path(params[:wiki_id])
    end
end

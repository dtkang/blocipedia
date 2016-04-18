class WikisController < ApplicationController
  def show
    @wiki = Wiki.find(params[:id])
  end
  
  def index
    @wikis = policy_scope(Wiki)
  end
  
  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user_id = current_user.id
    
    if @wiki.save
      @wiki.collaborators.create(:user_id => current_user.id, :wiki_id => @wiki.id)
      flash[:notice] = "Wiki has been created"
      redirect_to [@wiki]
    else
      flash[:error] = "Error occurred creating wiki, please try again"
      render :new
    end    
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to current_user
    else
      flash[:error] = "There was an issue deleting the wiki"
      render :show
    end
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki has been updated"
      redirect_to [@wiki]
    else
      flash[:error] = "Error occurred updating wiki, please try again"
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki 
  end
  
  def bulk_collaborators_update
    @wiki = Wiki.find(params[:wiki_id])
    
    if params[:email_addresses] != ""
      @user_email_addresses = params[:email_addresses].split(/,\s*/)
      @user_email_addresses.each do |user|
        if User.exists?(email: user)
          @new_user = User.where(email: user)
          if !@wiki.collaborators.exists?(user_id: @new_user)
            @wiki.collaborators.create(user_id: @new_user.ids[0], wiki_id: @wiki.id)
          end
        else
          flash[:error] = "User does not exist!"
        end
      end
    end
    redirect_to wiki_path(@wiki.id)
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title,:body,:private,:user_id)
  end
end

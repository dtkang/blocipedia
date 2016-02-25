class WikisController < ApplicationController
  def show
    @wiki = current_user.wikis.find(params[:id])
  end
  
  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.create(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki has been created"
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "Error occurred creating wiki, please try again"
      render :new
    end    
  end
  
  def destroy
    @wiki = current_user.wikis.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to current_user
    else
      flash[:error] = "There was an issue deleting the wiki"
      render :show
    end
  end
  
  def update
    @wiki = current_user.wikis.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.save
      flash[:notice] = "Wiki has been updated"
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "Error occurred updating wiki, please try again"
      render :edit
    end
  end

  def edit
    @wiki = current_user.wikis.find(params[:id])
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title,:body)
  end
end

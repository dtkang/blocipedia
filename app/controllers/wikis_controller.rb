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
    
    if @wiki.save
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
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title,:body,:private)
  end
end

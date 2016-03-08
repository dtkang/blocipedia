class WikisController < ApplicationController
  def show
    @wiki = current_user.wikis.find(params[:id])
    authorize @wiki
  end
  
  def index
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
  end
  
  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    
    if @wiki.save
      flash[:notice] = "Wiki has been created"
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "Error occurred creating wiki, please try again"
      render :new
    end    
  end
  
  def destroy
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
    @wiki = @wikis.find(params[:id])
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
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
    @wiki = current_user.wikis.find(params[:id])
    authorize @wiki
    
    @wiki.assign_attributes(wiki_params)
    
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki has been updated"
      redirect_to [current_user, @wiki]
    else
      flash[:error] = "Error occurred updating wiki, please try again"
      render :edit
    end
  end

  def edit
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
    @wiki = @wikis.find(params[:id])
    authorize @wiki 
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title,:body,:private)
  end
end

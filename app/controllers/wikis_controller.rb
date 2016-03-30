class WikisController < ApplicationController
  def show
    @wiki = Wiki.find(params[:id])
  end
  
  def index
    @wikis = Wiki.all
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
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
    p "*"*20
    p params[:id]
    p "*"*20
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
    p "*"*20
    p params[:id]
    p "*"*20    
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
    @wikis = WikiPolicy::Scope.new(current_user, Wiki).resolve
    p "*"*20
    p @wikis
    p params[:id]
    p @wikis.find(params[:id])
    p @wikis.exist?(params[:id])
    p "*"*20
    @wiki = @wikis.find(params[:id])
    authorize @wiki 
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title,:body,:private)
  end
end

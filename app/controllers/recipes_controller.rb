class RecipesController < ApplicationController
    before_action :set_recipe, only: [:edit, :update, :show, :like]
    before_action :require_user, except: [:show, :index, :like]
    before_action :require_user_like, only: [:like]
    before_action :require_same_user, only: [:edit, :update]

    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 6)
    end
    
    def show
        @recipe = Recipe.find(params[:id])
    end
    
    def new
       @recipe = Recipe.new 
    end
    
    def create 
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_user
        
        if @recipe.save
            flash[:success] = "Your recipe was created succesfully"
            redirect_to recipes_path
        else
            render :new 
        end
    end
    
    def edit
        
    end
    
    def update
        if @recipe.update(recipe_params)
           flash[:success] = "Your recipe has been updated succesfully" 
           redirect_to recipe_path(@recipe)
        else
            render :edit
        end
    end
    
    def require_user_like
        if !logged_in?
          flash[:danger] = "You must be logged in to perform this action"
          redirect_to :back
        end
    end
    
    def like
        like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
        if like.valid?
            flash[:success] = "Your vote has been counted"
            redirect_to :back
        else
            flash[:danger] = "you can only vote on a recipe once!"
            redirect_to :back
        end
    end
    
    
    
        private
            
            def recipe_params
                params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids:[])
            end
            
            def set_recipe
                @recipe = Recipe.find(params[:id])
            end
            
            def require_same_user
                if current_user != @recipe.chef
                    flash[:danger] = "You may only edit your own recipes!"
                    redirect_to recipes_path
                end
            end
    
end
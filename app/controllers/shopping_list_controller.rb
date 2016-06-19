class ShoppingListController < ApplicationController
  def index
    @shopping_lists = ShoppingList.all
  end

  def full_recursive
    @shopping_list = ShoppingList.find(params[:id])
    respond_to do |format|
      # format.json {render json: @shopping_list}
      format.json {render json: @shopping_list.to_json(:include => {:shopping_list_items => {:include => :item}})}
    end
  end
end

class ShoppingItemsController < ApplicationController
	def index
		@shopping_items = ShoppingItem.unmarked + ShoppingItem.marked
		@shopping_item  = ShoppingItem.new

	end

	def show
		@shopping_item = ShoppingItem.find(params[:id])
	end

	def new
		@shopping_item = ShoppingItem.new
	end

	def edit
		@shopping_item = ShoppingItem.find(params[:id])
	end

	def create
		item = Item.find(params[:shopping_item][:item])
		amount = params[:shopping_item][:amount].to_s
		@shopping_item = ShoppingItem.new()
		@shopping_item.item = item
		@shopping_item.amount = amount

		respond_to do |format|
			if @shopping_item.save
				format.html {redirect_to shopping_items_path, notice:'Shopping item was successfully created'}
				format.js
			else
				format.html {render action: "index", notice: "There were some errors, Shopping item not created"}
			end
		end
	end

	def update
		@shopping_item = ShoppingItem.find(params[:id])
		item = Item.find(params[:shopping_item][:item])
		amount = params[:shopping_item][:amount].to_s
		@shopping_item.item = item
		@shopping_item.amount = amount
		respond_to do |format|
			if @shopping_item.save
				format.html {redirect_to shopping_items_path, notice: "Shopping item successfully updated"}
			else
				format.html {render action: "edit"}
			end
		end
	end

	def destroy
		@shopping_item = ShoppingItem.find(params[:id])
		@shopping_item.destroy
		respond_to do |format|
			format.js
		end
	end

	def mark
		@shopping_item = ShoppingItem.find(params[:id])
		@shopping_item.marked = true
		@shopping_item.save!
		respond_to do |format|
			format.js
		end
	end

	def unmark
		@shopping_item = ShoppingItem.find(params[:id])
		@shopping_item.marked = false
		@shopping_item.save!
		respond_to do |format|
			format.js
		end
	end

	def test
		@shopping_items = ShoppingItem.all
		@items = Item.all
	end
end

class ShoppingListsController < ApplicationController
	# GET /shopping_lists
	# GET /shopping_lists.json
	def index
		@shopping_lists = ShoppingList.order("date ASC").all;
		@items = Item.all
		@shopping_list = ShoppingList.new

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @shopping_lists }
		end
	end

	# GET /shopping_lists/1
	# GET /shopping_lists/1.json
	def show
		@shopping_list = ShoppingList.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @shopping_list }
		end
	end

	# GET /shopping_lists/new
	# GET /shopping_lists/new.json
	def new
		@shopping_list = ShoppingList.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @shopping_list }
		end
	end

	# GET /shopping_lists/1/edit
	def edit
		@shopping_list = ShoppingList.find(params[:id])
	end

	# POST /shopping_lists
	# POST /shopping_lists.json
	def create
		@shopping_list = ShoppingList.new(params[:shopping_list])

		respond_to do |format|
			if @shopping_list.save
				format.html { redirect_to shopping_lists_path, notice: 'Shopping list was successfully created.' }
				format.json { render json: @shopping_list, status: :created, location: @shopping_list }
			else
				format.html { render action: "new" }
				format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /shopping_lists/1
	# PUT /shopping_lists/1.json
	def update
		@shopping_list = ShoppingList.find(params[:id])

		respond_to do |format|
			if @shopping_list.update_attributes(params[:shopping_list])
				format.html { redirect_to @shopping_list, notice: 'Shopping list was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /shopping_lists/1
	# DELETE /shopping_lists/1.json
	def destroy
		@shopping_list = ShoppingList.find(params[:id])
		@shopping_list.destroy

		respond_to do |format|
			format.html { redirect_to shopping_lists_url }
			format.json { head :no_content }
		end
	end

	#PUT /shopping_list/1/drop
	def drop
		@shopping_list = ShoppingList.find(params[:id])
		@item = Item.find(params[:item_id])
		shopping_item = ShoppingItem.where("item_id = #{@item.id} and shopping_list_id = #{@shopping_list.id}").first
		if shopping_item.nil?
			shopping_item = ShoppingItem.new
			shopping_item.item = @item
			shopping_item.amount = 0
			shopping_item.shopping_list = @shopping_list
		end
		shopping_item.amount += 1
		shopping_item.save!
		@amount = shopping_item.amount
		respond_to do |format|
			format.js
		end
	end

	#PUT /shopping_list/1/lock
	def lock
		@shopping_list = ShoppingList.find(params[:id])
		@shopping_list.lock = true
		@shopping_list.save!
		respond_to do |format|
			format.js
		end
	end
	def unlock
		@shopping_list = ShoppingList.find(params[:id])
		@shopping_list.lock = false;
		@shopping_list.save!
		respond_to do |format|
			format.js
		end
	end
end
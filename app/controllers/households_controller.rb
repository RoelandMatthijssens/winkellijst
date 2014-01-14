class HouseholdsController < ApplicationController
	before_filter :authenticate_user!
	# GET /households
	# GET /households.json
	def index
		@households = Household.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @households }
		end
	end

	# GET /households/1
	# GET /households/1.json
	def show
		@household = Household.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @household }
		end
	end

	# GET /households/new
	# GET /households/new.json
	def new
		@household = Household.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @household }
		end
	end

	# GET /households/1/edit
	def edit
		@household = Household.find(params[:id])
	end

	# POST /households
	# POST /households.json
	def create
		@household = Household.new(params[:household])
		@household.encrypt_password

		respond_to do |format|
			if @household.save
				format.html { redirect_to @household, notice: 'Household was successfully created.' }
				format.json { render json: @household, status: :created, location: @household }
			else
				format.html { render action: "new" }
				format.json { render json: @household.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /households/1
	# PUT /households/1.json
	def update
		@household = Household.find(params[:id])

		respond_to do |format|
			if @household.verify_password(params[:household][:password]) && @household.update_attributes(params[:household])
				@household.encrypt_password
				@household.save!
				format.html { redirect_to @household, notice: 'Household was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit", error: "could not update the household" }
				format.json { render json: @household.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /households/1
	# DELETE /households/1.json
	def destroy
		@household = Household.find(params[:id])
		@household.destroy

		respond_to do |format|
			format.html { redirect_to households_url }
			format.json { head :no_content }
		end
	end

	# subscribe /households/1
	def subscribe
		@household = Household.find(params[:id])
		password = params[:password]
		respond_to do |format|
			if @household && @household.verify_password(password)
				current_user.households << @household
				format.html {redirect_to households_url, notice: "successfully registered to household"}
			else
				format.html {redirect_to households_url, warn: "Could not register to the household"}
			end
		end
	end
end

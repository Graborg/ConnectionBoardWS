class PersonsController < ApplicationController
	before_filter :restrict_access, :only => :update
	before_filter :restrict_create, :only => :create
	
	def new
		@person = Person.new()
	end

	def create
		# dparams = params
		# #Does the request come from a form?
		# if params.has_key?(:post)
		# 	dparams = params[:post]
	 	# end
	 	params[:account_id] = self.account_id
	  	@person = Person.create(params.permit(:name, :expectations, :skills, :description, :mail, :account_id, :show_profile, :image))
  	  	render :json => @person
	end

	def edit
	  	@person = Person.find(params[:id])
	end


	def index
		result = Hash.new()
		result['persons'] = Person.all
 		@persons = render :json => result
	end
 

	def show
  		@person = render :json => Person.find(params[:id])
	end
	
	def update
			@person = Person.find(params[:id])
			if @person.update(params.permit(:name, :expectations, :skills, :description, :show_profile, :image))
			  render :json => @person
			else
			  render 'edit'
			end
	end

	def restrict_access
		@object_id = params[:id]
		super('person')
	end
end
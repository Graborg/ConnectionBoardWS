class ProjectsController < ApplicationController
	before_filter :restrict_access, :only => :update
	before_filter :restrict_create, :only => :create

	def new
		@project = Project.new()
	end

	def create
		#self.account_id
		# dparams = params

		# #Does the request come from a form?
		# if params.has_key?(:post)
		# 	dparams = params[:post]
	 #  	end
	 	params[:account_id] = self.account_id
	 	@project = Project.create(params.permit(:title, :subheading, :requested_skills, :gains, :mail, :description, :timeplan, :account_id, :show_project, :image))
  	  	render :json => @project
	end

	def edit
	  	@project = Project.find(params[:id])
	end


	def index
		result = Hash.new()
		result['projects'] = Project.all
 		@project = render :json => result

	end

	def show
  		@project = render :json => Project.find(params[:id])
	end
	
	def update
		@project = Project.find(params[:id])
		if @project.update(params.permit(:title, :subheading, :requested_skills, :gains, :mail, :description, :timeplan, :show_project, :image))
		  render :json => @project
		else
		  render 'edit'
		end
	end

	def restrict_access
		@object_id = params[:id]
		super('project')
	end
end

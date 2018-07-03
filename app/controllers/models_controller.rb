class ModelsController < ApplicationController

	def index
		@models = Model.where(project_id: params[:project_id])
	end

	def new
		@model = Model.new
		@projects = Project.pluck(:id, :name).map{ |id, name| ["#{name} (#{id})", id] }
	end

	def create
		@model = Model.new(params.require(:model).permit(:name, :comment, :project_id))
		if @model.save
			redirect_to models_path(project_id: @model.project_id) and return
		else
			redirect_to new_model_path and return
		end
	end

end

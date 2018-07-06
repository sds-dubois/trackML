class ProjectsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :api_create

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def show
		@project = Project.find(params[:id])
		@models = Model.where(project_id: @project.id)
	end

	def create
		@project = _new_project()
		if @project.save
			redirect_to projects_path and return
		else
			redirect_to new_project_path and return
		end
	end

	def api_create
		@project = _new_project()
		render json: {success: @project.save, id: @project.id}.to_json
	end

	def update
		@project = Project.find(params[:id])
		@project.update_attributes(params.require(:project).permit(:name))
		redirect_to @project
	end

	def export
		project = Project.find(params[:id])
		zip, filename = project.export()
		send_data zip, filename: filename
	end

	private

		def _new_project
			return Project.new(params.require(:project).permit(:name))
		end

end

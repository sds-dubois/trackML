class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(params.require(:project).permit(:name))
		if @project.save
			redirect_to projects_path and return
		else
			redirect_to new_project_path and return
		end
	end

end

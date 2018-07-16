class ModelsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: :api_create

	def index
		@models = Model.where(project_id: params[:project_id])
	end

	def new
		@model = Model.new
		@projects = Project.pluck(:id, :name).map{ |id, name| ["#{name} (#{id})", id] }
	end

	def create
		@model = _new_model()
		if @model.save
			redirect_to project_path(id: @model.project_id) and return
		else
			redirect_to new_model_path and return
		end
	end

	def api_create
		@model = _new_model()
		render json: {success: @model.save, id: @model.id}.to_json
	end

	def show
		@model = Model.find(params[:id])
		@experiments = Experiment.where(model_id: @model.id)
	end

	def inspect
		@model = Model.find(params[:id])
		@experiments = Experiment.where(model_id: @model.id)
		@parameters = @experiments.map{ |e| e.parameters.keys }.reduce([], &:+).uniq
		@metrics = @experiments.map{ |e| e.scores.keys }.reduce([], &:+).uniq
	end

	def parameter_graph
		experiments = Experiment.where(model_id: params[:id])
		parameter = params[:parameter]
		metrics = params[:metrics]

		if metrics.blank? || metrics.count == 0
			head :ok and return
		end

		detailed_exp = Experiment.detailed_list(experiments).select{ |e,m,s| metrics.include?(m) }
		data = detailed_exp.group_by(&:second).map do |k,v| 
        	{name: k, data: v.map{ |e,m,s| [e.parameters[parameter], s] }} 
		end
		render js: "new Chartkick.LineChart('explorer-chart', #{data.to_json}, {'legend': 'bottom'})"
	end

	def update
		@model = Model.find(params[:id])
		@model.update_attributes(params.require(:model).permit(:name, :comment))
		redirect_to @model
	end

	def destroy
		model = Model.find(params[:id])
		pid = model.project_id
		model.destroy
		redirect_to models_path(project_id: pid)
	end

	def export
		file, filename = Experiment.export_model(params[:id])
		send_data file, filename: filename
	end


	private

		def _new_model
			return Model.new(params.require(:model).permit(:name, :comment, :project_id))
		end

end

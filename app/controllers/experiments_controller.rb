class ExperimentsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:api_create, :api_bulk_create]

	def index
		model_id = params[:model_id]
		@experiments = Experiment.where(model_id: model_id)
		@model = Model.find(model_id)
	end

	def api_create
		experiment = Experiment.new(_experiment_params())
		render json: {success: experiment.save, id: experiment.id}.to_json
	end

	def api_bulk_create
		experiments = _experiment_bulk_params()
		results = experiments.map do |exp_params|
			experiment = Experiment.new(exp_params)
			[experiment.save, experiment.id]
		end
		render json: {success: results.map(&:first).all?, ids: results.map(&:last)}.to_json
	end

	def destroy
		exp = Experiment.find(params[:id])
		mid = exp.model_id
		exp.destroy
		redirect_to model_path(id: mid)
	end

	private

		def _experiment_params
			p = params.require(:experiment).permit(:parameters, :scores, :model_id).to_h.symbolize_keys
			p[:parameters] = YAML.load(p[:parameters])
			p[:scores] = YAML.load(p[:scores])
			return p
		end

		def _experiment_bulk_params
			return YAML.load(params[:experiments])
		end

end

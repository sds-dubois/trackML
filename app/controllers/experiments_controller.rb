class ExperimentsController < ApplicationController

	def index
		@experiments = Experiment.where(model_id: params[:model_id])
	end

end

class Project < ApplicationRecord
	has_many :models, dependent: :destroy
	require "zip"
	require "csv"

  	def export_models(models = nil)
		models = Model.where(model_id: self.id) if models.nil?
		file = CSV.generate do |csv|
			csv << ["Project: #{self.name} - id: #{self.id}"]
			csv << models.first.csv_headers() if models.count > 0
			models.each{ |m| csv << m.csv_dump() }
		end
		filename = "project_#{self.id}_models.csv"
    	return file, filename
  	end

	def export
		models = Model.where(project_id: self.id)

		zip_buffer = Zip::OutputStream.write_buffer do |out|
			pfile, pfilename = self.export_models(models)
			out.put_next_entry(pfilename)
			out.write(pfile)

			models.each do |model|
				mfile, mfilename = Experiment.export_model(model.id)
				if !mfile.blank?
					out.put_next_entry(mfilename)
					out.write(mfile)
				end
			end
		end

		return zip_buffer.string, "project_#{self.id}.zip"
	end

end

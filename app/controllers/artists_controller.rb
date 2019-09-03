class ArtistsController < ApplicationController
	before_action :get_object, :only=>[:profile, :upload_paintings]

	def profile
		@paintins_array = Painting.where(user_id: @artist.id)
	end

	def edit_profile
		render :layout=> false
	end

	def upload_paintings

		@artist.paintings.build(painting_params)

		if @artist.save
			redirect_to artist_profile_path(id: @artist.try(:id)), :notice => "Uploaded Successfully!!"
		else
			redirect_to artist_profile_path(id: @artist.try(:id)), :alert => @artist.errors.full_messages.to_sentence
		end
	end

	private 

	def get_object
		@artist = User.find_by(id: params[:id])

		unless @artist.present?
			redirect_to root_path, alert: "Record not found!!"
		end
	end

	def painting_params
		params.require(:painting).permit(:name, :painting)
	end
end

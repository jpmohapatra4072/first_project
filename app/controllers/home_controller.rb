class HomeController < ApplicationController

	def index
		@artist_list = User.all
	end
end

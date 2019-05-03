module CitiesHelper
	def create
		#@city = City.create

		@city = City.new
		@city.save
		#(name: params[:city_name], zip_code: params[:zip_code])
	end
end

require 'cities_helper'
class UsersController < ApplicationController

include CitiesHelper

	def show
		@user_precis = User.find(params[:id])
		@user_city_id = @user_precis.city_id
		@user_city = City.find(@user_city_id).name
	end

	def new
		@user = User.new
	end

	def create
		if City.find_by(name: params[:city_name])
			@city_db = City.find_by(name: params[:city_name])
			@user = User.new(email: params[:email], password: params[:password],
				first_name: params[:first_name], last_name: params[:last_name], 
				age: params[:age], city: @city_db)
			@user.save
		else
			@city = City.new(name: params[:city_name], zip_code: params[:zip_code])
			# @city.name = params[:city_name]
			# @city.zip_code =  params[:zip_code]
			@user = User.new(email: params[:email], password: params[:password],
				first_name: params[:first_name], last_name: params[:last_name], 
				age: params[:age], city: @city)
			@user.save
		end


		if @user.save 
			#@city.save
			session[:user_id] = @user.id
			redirect_to root_path
			flash[:success] = "Your account has been created with success, my coño friend!"
		else
			flash[:alert] = "Try again, my coño friend!"

			render 'new'
		end
	end
end
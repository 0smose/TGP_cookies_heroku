class AboutController < ApplicationController
  def team
  end

  def contact
  end

  def welcome
  	puts params[:first_name]
  end
 end
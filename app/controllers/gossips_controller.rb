class GossipsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def index
    @gossip = Gossip.all
  end

  def show
    @gossip_precis = Gossip.find(params[:id])
    @gossip_user_id = @gossip_precis.user_id
    @gossip_user_city_id = User.find(@gossip_user_id).city_id
    @gossip_user_city = City.find(@gossip_user_city_id).name
    # @comment = Comment.new
  end  

  def new
    @gossip_new = Gossip.new
  end

  def create
    # anonymous = User.find_by(last_name: "Nymous")
    @gossip_new = Gossip.new(title: params[:title], content: params[:content], user: current_user)
    @gossip_new.save

    if @gossip_new.save
    	redirect_to action:'index'
    	flash[:success] = "Your gossip has been registered with success, my coño friend!"
    else
    	render 'new'
    end

    puts @gossip_new.user 
  end

  def edit
    @gossip_precis = Gossip.find(params[:id])
    redirect_to root_path, notice: "You can't edit this gossip ma biche"  unless current_user == @gossip_precis.user
   
   
  
  end

  def update
    @gossip_precis = Gossip.find(params[:id])
    if current_user == @gossip_precis.user
      if @gossip_precis.update(gossip_params)
        redirect_to action:'index'
        flash[:success] = "Your gossip has been edited with success, my coño friend!"
      else
        flash[:alert] = "Try again, my coño friend!"
        render :edit
      end
    else 
      redirect_to root_path, notice: "You can't edit this gossip ma biche"  
    end
  end

  def destroy
        @gossip_precis = Gossip.find(params[:id])
      if current_user != @gossip_precis.user
        redirect_to gossip_path(@gossip_precis.id), notice: "You can't delete this gossip ma biche"  
      else
        @gossip_precis.destroy
        redirect_to action: 'index'
        flash[:success] = "Your gossip has been deleted with success, my coño friend!"
      end
  end


private

def gossip_params

  params.require(:gossip).permit(:title, :content)

end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

end



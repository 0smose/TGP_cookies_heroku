class CommentsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :show]

  def index
    @comments = Comment.all
  end


  def show
    @gossip_id = Gossip.find(params['gossip_id']).id
    @comment = Comment.find_by(@gossip_id)
  end

  
  def new
    @comment = Comment.new
  end

  def create
    @gossip = Gossip.find(params['gossip_id']) 

    @comment = Comment.new(content: params[:content], user_id: current_user.id, gossip_id: @gossip.id)
    @comment.save
    redirect_to gossip_path(@gossip.id)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @gossip_precis = Gossip.find(params[:gossip_id])
    @comment.save
    
    if @comment.update(content: params[:content])
      redirect_to gossip_path(@gossip_precis.id)
      flash[:success] = "Your comment has been edited with success, my coño friend!"
    else
      flash[:alert] = "Try again, my coño friend!"
      render :edit
    end
  end





  def destroy
     @comment = Comment.find(params[:id])
     @gossip_precis = Gossip.find(params[:gossip_id])
     @comment.destroy
     redirect_to gossip_path(@gossip_precis.id)
     flash[:success] = "Your comment has been deleted with success, my coño friend!"
  end



private

def comment_params

  params.require(:comment).permit(:content)

end

  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end


end

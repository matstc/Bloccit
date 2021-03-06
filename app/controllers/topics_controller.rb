class TopicsController < ApplicationController
  def index
  	@topics = Topic.all
  	authorize @topics
  end

  def new
  	@topic = Topic.new
  	authorize @topic
  end

  def show
  	@topic = Topic.find(params[:id])
  	@posts = @topic.posts
  	authorize @topic
  end

  def edit
  	@topic = Topic.find(params[:id])
  	authorize @topic
  end

  def create
  	@topic = Topic.new(topic_params)
  	authorize @topic
  	if @topic.save
  		redirect_to @topic, notice: "Topic was saved successfully."
  	else
  		flash[:error] = "Error creating topic.Please try again."
  		render :new
  	end
  end

  	 def update
     @topic = Topic.find(params[:id])
     authorize @topic
     if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
       redirect_to @topic
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
	end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.destroy
      flash[:notice] = "'#{@topic.name}' was deleted successfully"
      redirect_to topics_path
    else
      flash[:notice] = "Failed to delete topic"
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end

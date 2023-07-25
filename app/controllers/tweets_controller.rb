class TweetsController < ApplicationController
    include ArticlesComments
    
    before_action :set_commentable!
    before_action :set_question
    after_action :verify_authorized  # Eto Podkluczenie "Awtorizacii"

    def create
      @tweet = @commentable.tweets.build tweet_params
      authorize @tweet  # Eto Podkluczenie "Awtorizacii"

      if @tweet.save
        flash[:success] = t".success" # Window Podtwerzdenija
        redirect_to article_path(@article)
      else
        @tweet = @tweet.decorate
        load_articles_comments do_render: true
      end
    end
   
    def destroy
      tweet = @commentable.tweets.find params[:id]
      authorize tweet   # Eto Podkluczenie "Awtorizacii"

      tweet.destroy
      flash[:success] = t'.success'
      redirect_to article_path(@article)
    end
    
    private
  
    def tweet_params
      params.require(:tweet).permit(:body).merge(user: current_user)
    end
  
    def set_commentable!
      klass = [Article, Comment].detect { |c| params["#{c.name.underscore}_id"] }
      raise ActiveRecord::RecordNotFound if klass.blank?
  
      @commentable = klass.find(params["#{klass.name.underscore}_id"])
    end
  
    def set_question
      @article = @commentable.is_a?(Article) ? @commentable : @commentable.article
    end
    
  end
  
  
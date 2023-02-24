class CommitsController < ApplicationController
    include ArticlesComments
    before_action :set_commentable!
    before_action :set_question
  
    def create
      @commit = @commentable.commits.build commit_params
  
      if @commit.save
        #flash[:success] = 'success'
        redirect_to article_path(@article)
      else
        @commit = @commit.decorate
        load_articles_comments do_render: true
      end
    end
  
    
    private
  
    def commit_params
      params.require(:commit).permit(:body).merge(user: current_user)
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
  
  
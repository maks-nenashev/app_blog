module ArticlesComments
    extend ActiveSupport::Concern
  
    included do
      def load_articles_comments(do_render: false)
        @article = @article.decorate
        @comment ||= @article.comments.build
        #@comments = @article.comments.order(created_at: :desc).page(params[:page]).per 2
        @comments = @article.comments.includes(:user).order(created_at: :desc).page(params[:page]).per 2
        @comments = @comments.decorate
        render('articles/show') if do_render
      end
    end
  end
  
module ArticlesComments
    extend ActiveSupport::Concern
  
    included do
      def load_articles_comments(do_render: false)
        @article = @article.decorate
        @comment ||= @article.comments.build
        @pagy,@comments = pagy @article.comments.includes(:user).order(created_at: :desc),items:3
        @comments = @comments.decorate
        render('articles/show') if do_render
      end
    end
  end
  
class CommentsController < ApplicationController
  before_action :set_question!  # :set_question! "Refactoring"

    def create# : create (отправить форму. POST)  
        @comment = @article.comments.build(comment_params)  #Comment привязывам к Article
  
      if@comment.save
        flash[:success] = "Comment created!"  #Window Podtwerzdenija
        redirect_to article_path(@article)   #"perenaprowlenie" 
      else
        @comments = Comment.order created_at: :desc
        render 'articles/show'            #"perenaprowlenie"      
      end
   end
    
    def destroy # Udalenie kaЖdogo commeta
       comment = @article.comments.find params[:id]
       comment.destroy
       flash[:success] = "Comment deleted!"     #Window Podtwerzdenija
       redirect_to article_path(@article)   #"perenaprowlenie" 
    end
    
    def show # Kontroller zaprosil "SHOW" dla udalenija
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
     end
    
     private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    def set_question!  #:set_question!  "Refactoring"
      @article = Article.find params[:article_id]
    end
  

end


#def destroy
  #  comment = @article.comments.find params[:id]
   # comment.destroy
   # flash[:success] = "Answer deleted!"     #Window Podtwerzdenija
   # redirect_to article_path(@article)   #"perenaprowlenie" 
  #end
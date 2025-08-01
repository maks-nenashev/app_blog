class CommentsController < ApplicationController
   include ArticlesComments # Rafactoring "articles_comments.rb"
   before_action :authenticate_user!, :only => [:create]
  
   before_action :set_article!  # 1:set_article! "Refactoring"
   before_action :set_comment!, only: [:edit, :update, :show, :destroy] # только для edit/update/destroy # 2:set_commint! "Refactoring"
                                #Krome "create"
   before_action :authorize_comment!, only: [:edit, :update, :new, :show, :create, :destroy] # Eto Podkluczenie "Awtorizacii"
   after_action :verify_authorized 

    def update  # 5 Wnosim izmenrnie w redaktirowanie
        #@comment = @article.comments.find params[:id]--:set_comment!  # 2:set_commint! "Refactoring"
        if@comment.update(comment_update_params) # Obnowlaem s nowymi parametromi
          flash[:success] = t".success" #Window Podtwerzdenija
          redirect_to article_comment_path(@article, @comment)
         else
          render action: 'edit'    #"perenaprowlenie"
       end
      end
   
    def edit  # 4 Wozwrat i Redactirowanie
        #@comment = @article.comments.find params[:id]--:set_comment!  # 2:set_commint! "Refactoring"
     end
   
     
  #def new  # 3 создать - new (отобразить форму. GET)
     # @article = Article.new  # Пустым оставлять тельзя!
      def new
        @article = Article.find(params[:article_id])
        @comment = @article.comments.new
      end
      
    #end
   
  def create# 1: create (отправить форму. POST)  
        #@article = Article.find(params[:article_id]) 
        @comment = @article.comments.new(comment_create_params)  #Comment привязывам к Article
      if@comment.valid?
          @comment.save
        flash[:success] = t".success"  #Window Podtwerzdenija
        redirect_to article_comment_path(@article, @comment)  #"perenaprowlenie" 
      else
        render 'articles/show'
        #load_articles_comments(do_render: true) # Rafactoring "articles_comments.rb"
        #@comments = @article.comments.order created_at: :desc
        #render 'articles/show'            #"perenaprowlenie"      
      end
    end
   
    def destroy # 2 Udalenie kaЖdogo commeta
       #@comment = @article.comments.find params[:id]--:set_comment!  # 2:set_commint! "Refactoring"
       @comment.destroy
       flash[:success] = t".success"     #Window Podtwerzdenija
       redirect_to article_path(@article)   #"perenaprowlenie" 
    end
    
    def show # Kontroller zaprosil "SHOW" dla udalenija
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        #@comment.destroy
        #flash[:success] = t".success"     #Window Podtwerzdenija
        #redirect_to article_path(@article)
      end
    
     private
  
    def comment_create_params
      params.require(:comment).permit(:title, :body, images: []).merge(user: current_user)
    end                                      #Podkluchenie comment k "user"
    
    def comment_update_params
      params.require(:comment).permit(:title, :body, images: [])
    end                                     
  #/////////////////////////////////////////////////////////////////////////////////

    def set_article!  #1:set_article!  "Refactoring"
      @article = Article.find params[:article_id]
    end
    
    def set_comment! #2:set_comming!  "Refactoring"
      @comment = @article.comments.find params[:id]
    end

    def authorize_comment!   # Eto Podkluczenie "Awtorizacii" :Role
      authorize(@comment || Comment)
     end
end


#def destroy
  #  comment = @article.comments.find params[:id]
   # comment.destroy
   # flash[:success] = "Answer deleted!"     #Window Podtwerzdenija
   # redirect_to article_path(@article)   #"perenaprowlenie" 
  #end
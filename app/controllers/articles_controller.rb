class ArticlesController < ApplicationController
   include ArticlesComments
   #before_action :require_authentication, except: %i[show index]# Ne zaloginenye mogut smotretь
   before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
   before_action :set_article!, only: %i[show destroy edit update]  # @article = Article.find params[:id]   "Refactoring"
   before_action :authorize_article! # Eto Podkluczenie "Awtorizacii"
   after_action :verify_authorized                                                         
 
   def index # 4: Wywod wsech zapisej!
    @pagy, @articles = pagy Article.includes(:user).order(created_at: :desc),items:3
    @articles = @articles.decorate
    #authorize @article
   end                                               # chtoby "articles" wywodilo poslednie wwerchu
  
 def show  # 3: Wywodim bazu po :ID
     load_articles_comments #Rafactoring "articles_comments.rb"
     #@article = Article.find params[:id]    :before_action :set_question! "Refactoring"
     #@comment = @article.comments.build       # Podkluchenie  "Commint"
     #@pagy, @comments = pagy @article.comments.order(created_at: :desc) #razbiw na stranicy # Podkluchenie  "Commint"
  end                             # chtoby "comments" wywodilo poslednie wwerchu
    

 def new  # 1: создать - new (отобразить форму. GET)
     @article = Article.new  # Пустым оставлять тельзя!
  end
  
 def create # 2: create (отправить форму. POST)   
     #@article = Article.new(article_params)
     @article = current_user.articles.build(article_params)# Podkluczenie "user"
     #authorize @article
     if @article.valid?
     @article.save 
     flash[:success] = t".success"   #Window Podtwerzdenija
     redirect_to @article #У нас происходит редирект на "show" поэтому представление --
                          #--"create" нам теперь не нужно, его можно удалить.
  else
     render action: 'new'  #"perenaprowlenie"
   end
 end
  
 def edit   # 5: Wozwrat i Redactirowanie
    #@article = Article.find params[:id]    :before_action :set_question! "Refactoring"
 end

 def update #6  Wnosim izmenrnie w redaktirowanie
    #@article = Article.find(params[:id])      :before_action :set_question! "Refactoring"

  if @article.update(article_params) # Obnowlaem s nowymi parametromi
     redirect_to @article
     flash[:success] = t".success" #"Article updated!" #Window Podtwerzdenija
    else
     render action: 'edit'    #"perenaprowlenie"
  end
end

def destroy # Delite publikacij
  #@article = Article.find(params[:id]) # To чto hotim udalitь  :before_action :set_question! "Refactoring"
  @article.destroy
  flash[:success] = t".success"     #Window Podtwerzdenija
  redirect_to @article  #"perenaprowlenie"
 
end

#////////////////////////////////////////////////////////////////////////////////////
 private

  def article_params
    params.require(:article).permit(:title, :text, :avatar)
 end

  def set_article!  # :before_action :set_question! only[show destroy edit update] "Refactoring"
    @article = Article.find(params[:id])
 end
 
  def authorize_article!   # Eto Podkluczenie "Awtorizacii"
   authorize(@article || Article)
  end

end

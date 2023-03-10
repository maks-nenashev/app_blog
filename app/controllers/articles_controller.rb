class ArticlesController < ApplicationController
#before_action :authenticate_user!, :only => [:new, :create]# Blokerowka registracii!
                                                             
def index   # 4: Wywod wsech zapisej!
    @articles = Article.all
 end
  
 def show  # 3: Wywodim bazu po :ID
   @article = Article.find(params[:id])
 end

 def new  # 1: создать - new (отобразить форму. GET)
 end
  
 def create # 2: create (отправить форму. POST)   
     @article = Article.new(article_params)
     #@article = current_user.Article.new(article_params)
     if @article.valid?
     @article.save 
     redirect_to @article #У нас происходит редирект на "show" поэтому представление --
                          #--"create" нам теперь не нужно, его можно удалить.
  else
     render action: 'new'  #"perenaprowlenie"
   end
 end
  
 def edit   # 5: Wozwrat i Redactirowanie
  @article = Article.find(params[:id])
 end

 def update #6  Wnosim izmenrnie w redaktirowanie
  @article = Article.find(params[:id])

  if @article.update(article_params) # Obnowlaem s nowymi parametromi
     redirect_to @article
  else
     render action: 'edit'    #"perenaprowlenie"
  end
end

def destroy # Delite publikacij
  @article = Article.find(params[:id]) # To чto hotim udalitь
  @article.destroy
  
  redirect_to article_path  #"perenaprowlenie"
end

#////////////////////////////////////////////////////////////////////////////////////
 private

 def article_params
   params.require(:article).permit(:title, :text)
 end


end

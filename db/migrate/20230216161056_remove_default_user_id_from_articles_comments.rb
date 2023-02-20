class RemoveDefaultUserIdFromArticlesComments < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column_default :articles, :user_id, from: User.first.id, to: nil
      change_column_default :comments, :user_id, from: User.first.id, to: nil
    end
  
    def down
      change_column_default :articles, :user_id, from: nil, to: User.first.id
      change_column_default :comments, :user_id, from: nil, to: User.first.id
    end
  
  end
end

  #rails g migration remove_default_user_id_from_articles_comments

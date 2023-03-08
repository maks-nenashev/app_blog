class AddUserIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, null: false, foreign_key: true #, default: User.first.id "Eto nugno pri zapeske"
                                                                   #pri uszanoj baze
  end
end
         #rails g migration add_user_id_to_comments user:belongs_to

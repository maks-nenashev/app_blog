class User < ApplicationRecord
                # Ролевая модель, enum
  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role
  attr_accessor :old_password, :remember_token, :admin_edit
     
  # Awtorizacija
  def guest?
    false
    end
  
  def author?(obj)
       obj.user == self
     end
  #//////////////////////////////////////////////////////////////////////////////////////////

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         #podkluczenie "rabotaet"
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
             
        
end

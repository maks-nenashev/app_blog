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
  
  has_one_attached :avatar
     def avatar_tumbnail
          if avatar.attached?
            #avatar.variant(resize: "150x150>").processed 
            avatar.variant(resize_to_fill: [150, nil]).processed 
          end
      end
           #podkluczenie "rabotaet"
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
             
        
end

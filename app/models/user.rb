class User < ApplicationRecord
              #podkluczenie "rabotaet"
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
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
 #_______________________________________________________________________________ 
  has_one_attached :avatar # 1 conect avatar
  after_commit :add_default_avatar, only: %i[create update]  # 2 Connecting an empty avatar   
  # 1 conect avatar
      def avatar_tumbnail
          if avatar.attached?
            #avatar.variant(resize: "150x150>").processed 
            avatar.variant(resize_to_fill: [150, nil]).processed 
          else 
            "avatar_blog.jpg" 
          end
      end
     
    private # 2   Connecting an empty avatar   
      def add_default_avatar
        unless avatar.attached?
          avatar.attach(
            io: File.open(
              Rails.root.join(
                'app','assets','images','avatar_blog.jpg'
              )
            ),
            filename: 'avatar_blog.jpg',
            content_type: 'image/jpg'
          )
        end
      end      
#_______________________________________________________________________________________      
  end

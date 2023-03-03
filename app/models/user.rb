class User < ApplicationRecord
                # Ролевая модель, enum
  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role

  attr_accessor :old_password, :remember_token, :admin_edit
  
  #has_secure_password validations: false #, password_digest
  #validate :password_presence 
  #validate :password_digest
  #validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }
  #validates :password, confirmation: true, allow_blank: true,
                    # length: { minimum: 6, maximum: 10 }
  #validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  #validate :password_complexity
  #validates :role, presence: true
  #//////////////////////////////////////////////////////////////////////////////////////////

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         #podkluczenie "rabotaet"
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
             
        
  end

class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, 
    :lockable
       
  has_many :services, :dependent => :destroy
  has_many :ideias, :dependent => :destroy
  has_many :sugestoes, :dependent => :destroy


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :username, :nome, :dtnascimento, :url
  
  validates :username, :length => { :maximum => 40 }
  validates :nome, :length => { :maximum => 200 }
  validates :url, :length => { :maximum => 50 }
  
end

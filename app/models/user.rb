class User < ActiveRecord::Base
  has_many :wikis
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  def admin?
    role == "admin"
  end
  
  def premium?
    role == "premium"
  end
  
  def standard?
    role == "standard"
  end
end

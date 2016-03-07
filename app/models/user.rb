class User < ActiveRecord::Base
  has_many :wikis
  attr_accessor :role
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def create
    super do |resource|
      p "Here are the params: "
      p params
      @role = params(:role)
    end
  end
         
  def admin?
    p '*'*20
    p role
    p '*'*20
    p role == "admin"
  end
  
  def premium?
    p '*'*20
    p role
    p '*'*20
    p role == "premium"
  end
  
  def standard?
    p '*'*20
    p role
    p '*'*20
    p role == "standard"
  end
end

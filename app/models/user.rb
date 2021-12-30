class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Original config:
  # devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end

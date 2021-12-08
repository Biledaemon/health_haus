class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :contracts, dependent: :destroy
  has_many :plans, through: :contracts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

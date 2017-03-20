class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :nickname, presence: true, length: { maximum: 6 }
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :email, presence: true

  has_many :messages
  has_many :user_chat_groups
  has_many :chat_groups , through: :user_chat_groups
  accepts_nested_attributes_for :user_chat_groups
end

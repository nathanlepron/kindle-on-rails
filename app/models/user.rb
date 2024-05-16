class User < ApplicationRecord
    has_secure_password
    validates :firstname, :lastname, presence:true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end

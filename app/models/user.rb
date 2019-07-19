class User < ActiveRecord::Base
    validates :name, presence: { message: "Error : no name specified" }
    validates :name, format: { with: /\A[\p{L}\s']+\z/, message: "Error : only allows letters, spaces, and apostrophe" }

    validates :email, presence: { message: "Error : no email specified" }
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Error : invalid email address" }

    #validates :sciper, presence: { message: "Error : no sciper specified" }
    #validates :sciper, numericality: { only_integer: true, message: "Error : sciper should contain digits only" }
    #validates :sciper, length: { is: 6, message: "Error : sciper should have 6 numbers" }
    validates :sciper, format: { with: /\A\d{6}?\z/, message: "Error : sciper should have 6 numbers or left blank" }
    validates :sciper, uniqueness: { message: "Error : another user already has this sciper", conditions: -> { where.not(sciper: '') }}

    validates :balance, presence: { message: "Error : no balance specified" }
    #validates :balance, numericality: { message: "Error : balance should be something like 20.0, -23.25..."}
end

# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  username              :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string(100)
#  age                   :string
#  political_affiliation :string
#

#u = User.new(age: 2, email: "mimi@aa.io", username:"mimi", 
#political_affiliation: "aa", password:"hunter12")
# u.age = 2
# u.email = mimi@aa.io
# u.pa = aa
# u.password = hunter12

#mimi = User.find_by(username:"mimi")
#mimi = mimi.update(email:"mimiparsons@aa.io")

class User < ApplicationRecord
    validates :username, :email, :session_token, :password_digest, presence: true, uniqueness: true
    validates :password, length: {minimum: 6 }, allow_nil: true

    #this attr_reader will return the password
    attr_reader :password
    # before_validation :ensure_session_token
    after_initialize :ensure_session_token
    
    has_many :chirps, 
        primary_key: :id, 
        foreign_key: :author_id, 
        class_name: :Chirp

    has_many :likes, 
        primary_key: :id, 
        foreign_key: :liker_id, 
        class_name: :Like
      
    has_many :liked_chirps, 
        through: :likes,
        source: :chirp
    
    has_many :comments, 
        foreign_key: :author_id, 
        class_name: :Comment


  # 0. Warm up 
  # get all records
  # SELECT * FROM users

    # User.all

  # find takes in the id
  # SELECT * FROM users WHERE id = 4

    # User.find(34)
    # User.find(32)

  # find_by takes any attribute
  # SELECT * FROM users WHERE age = 11

    # User.find_by(username: "cow_luva")

  # Can also use where.not 
  # SELECT * FROM users WHERE age < 100

    # User.where.not('age >= ?', 100)



  # 1. Suppose we're approached by a broomstick company, 
  # and they want to run ads targeted toward the 11-year-old 
  # demographic.

    # User.where(age: 11)
  

  # 2. Maybe we also want to find all the chirps about Elliot?
  # Take a second with your PARTNER TO DISCUSS how we can make this query

  #  Chirp.where("body LIKE '%Elliot%'")


  # 3. Let's look at what is actually returned
  # It looks like an array but it's not !
  # names = ["Harry Potter", "Hermione Granger"]
  # User.where(username: names).is_a?(Array) 
  # User.where(username: names).class 

  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16) 
    self.save!
    self.session_token
  end
  
  def self.find_by_credentials(username,password)
    user= User.find_by(username: username)
  
    user && user.is_password?(password) ? user : nil
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end

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

class User < ApplicationRecord
    validates :username, :email, presence: true, uniqueness: true
    
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

    # Warm up 

  # get all records
  # SELECT * FROM users

    # User.all

  # find takes in the id
  # SELECT * FROM users WHERE id = 4

    # User.find(4)

  # find_by takes any attribute
  # SELECT * FROM users WHERE age = 11

    # User.find_by(age: 11)
    
  # Can also use where.not 
  # SELECT * FROM users WHERE age < 100

    # User.where.not('age >= ?', 100)



  # 1. Suppose we're approached by a broomstick company, 
  # and they want to run ads targeted toward the 11-year-old 
  # demographic.

    # User.where(age: 11)
  

  # 2. Maybe we also want to find all the chirps about Harry?
  # Take a second with your PARTNER TO DISCUSS how we can make this query

  #  Chirp.where("body LIKE '%Harry%'")


  # 3. Let's look at what is actually returned
  # It looks like an array but it's not !
  # names = ["Harry Potter", "Hermione Granger"]
  # User.where(username: names).is_a?(Array) 
  # User.where(username: names).class 

end

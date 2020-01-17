# == Schema Information
#
# Table name: chirps
#
#  id        :bigint           not null, primary key
#  body      :string(140)      not null
#  author_id :integer          not null
#

class Chirp < ApplicationRecord
    validates :body, :author_id, presence: true
    
    # custom validation using method
    validate :body_too_long

    belongs_to :author,
        primary_key: :id,           # always id
        foreign_key: :author_id, 
        class_name: :User           # or "User"
    
    has_many :likes, 
        primary_key: :id, 
        foreign_key: :chirp_id, 
        class_name: :Like

    has_many :likers,
        through: :likes,
        source: :user
    
    has_many :comments, 
        foreign_key: :chirp_id, 
        class_name: :Comment

    def body_too_long
        if self.body && self.body.length > 140
            # errors hash provided by rails
            errors[:body] << "Sorry! Can't have more than 140 chars"
        end
    end


    # ======================================
    # ===  ActiveRecord Lecture DEMO  ======
    # ======================================

    
# 1. So suppose we're constructing our feed page, 
# and we want to find all of the chirps for a particular user.
# 
# SELECT 
#   * 
# FROM 
#   chirps JOIN users ON chirps.author_id = users.id
# WHERE 
#   users.username = "Harry Potter"

    # Chirp.joins(:author).where(users: { username: "Harry Potter" })  # INCLUDESSSSS NO QUERYY USEEE THISSS AS EXAMPLE

# 2. Let's now return all of the chirps liked 
# by people politically affiliated with Gryffindor (Harry and Hermione).
# SELECT 
#   chirps.* 
# FROM 
#   chirps JOIN 
#   likes ON 
#     likes.chirp_id = chirps.id JOIN 
#   users ON 
#     users.id = likes.user_id
# WHERE 
#   users.political_affiliation = "Gryffindor"  
  
  # Chirp.joins(:likers).where(users: { political_affiliation: "Gryffindor" })

# 3. This is great, but we have duplicates! Both Harry and Hermione liked the 
# same chirp. 
# How can we get rid of them?

# 4. BONUS: Find all the chirps created by someone of age 11 that were also liked 
# by someone of age 11.
# 
# SELECT 
#   chirps.*
# FROM 
#   chirps JOIN 
#   likes ON 
#     likes.chirp_id = chirps.id JOIN 
#   users AS liker ON 
#     liker.id = likes.user_id JOIN 
#   users AS author ON 
#     author.id = chirps.author_id
# WHERE 
#   liker.age = 11 AND author.age = 11


    # Chirp.joins(:likers, :author).where(users: { age: 11 }).where(authors_chirps: { age: 11 })

# 5. Let's find the chirps without any likes :(
# Hint: What kind of join will we need if we want to include `nil` values?
#   
# SELECT 
#   chirps.* 
# FROM 
#   chirps LEFT OUTER JOIN 
#   likes ON likes.chirp_id = chirps.id
# WHERE 
#   likes.id IS NULL 

    # Chirp.left_outer_joins(:likes).where(likes: { id: nil })

# ====================== end demo 2 ===


# ===== BREAK === then start demo 3 ===


# So during the break one of our potential investors called us and asked us how 
# much users are interacting with each others' chirps...
# 
# 6. Let's find out how many likes each of our chirps have
# SELECT 
#   chirps.id, 
#   chirps.body,
#   COUNT(*) as num_likes
# FROM 
#   chirps JOIN 
#   likes ON chirps.id = likes.chirp_id
# GROUP BY 
#   chirps.id 
  
  # Chirp.select(:id, :body, "COUNT(*) as num_likes").joins(:likes).group(:id)


# 7. HAVING - Let's find the chirps with at least 3 likes
# 
# SELECT 
#   chirps.id, 
#   chirps.body,
#   COUNT(*) as num_likes
# FROM 
#   chirps JOIN 
#   likes ON chirps.id = likes.chirp_id
# GROUP BY 
#   chirps.id 
# HAVING 
#   COUNT(*) >= 3

  # Chirp.joins(:likes).group(:id).having("COUNT(*) >= 3").pluck(:body, "COUNT(*) as num_likes")

  
# The world famous broomstick Company, Nimbus has made an account on BlueBird! 
# Let's see who's liking their chirps the most and use that information to 
# make some $$$. How could we construct a query to find this out?
# 
# Student Challenge: Find who is liking Nimbus's chirps the most
# 
# SELECT 
#   liker.username, 
#   COUNT(*) as num_likes
# FROM 
#   chirps JOIN 
#   likes ON 
#     chirps.id = likes.chirp_id JOIN 
#   liker ON 
#     likes.user_id = liker.id JOIN 
#   users AS author ON 
#     author.id = chirps.author_id
# WHERE 
#   author.username = 'Nimbus'
# GROUP BY 
#   liker.username
# ORDER BY 
#   num_likes DESC

  # Chirp.joins(:likers, :author).group("users.username").where(authors_chirps: { username:  'Nimbus' }).order("num_likes DESC").pluck("users.username, COUNT(*) as num_likes")

# We want to find the chirp with the most comments so we can figure 
# out what content is getting the most engagement. Once we find that chirp 
# we want to actually see what all the comments are and send them along to our 
# marketing team, so they can figure out people and businesses to target ads 
# towards and get them on our platform. How can we accomplish this? 
# (Hint: it might take more than one query)

# Comment.where(chirp_id: most_commented_chirps[0].id)


# ===================================
  # N + 1 demo
# ===================================

#   def self.see_chirp_authors_n_plus_one
#     # the "+1"
#     chirps = Chirp.all

#     # the "N"
#     chirps.each do |chrp|
#       puts chrp.author.username
#     end

#   end

#   def self.see_chirps_optimized
#     # pre-fetches data
#     chirps = Chirp.includes(:author).all

#     chirps.each do |c| 
#       # uses pre-fetched data 
#       puts c.author.username
#     end
#   end

end

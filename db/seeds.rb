# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the 'rails db:seed' command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  User.destroy_all

  # Wizards
  angela = User.create!(username: "loves_capy", age: 11, political_affiliation: "Gryffindow", email: "chosenone@aa.io")
  dean = User.create!(username: "dean_machine", age: 11, political_affiliation: "Slytherin", email: "deans_diary@aa.io")
  joe = User.create!(username: "trader_joes_4lyf3", age: 11, political_affiliation: "Hufflepuff", email: "thetraderjoe@aa.io")
  alissa = User.create!(username: "cow_luva", age: 11, political_affiliation: "Ravenclaw" , email: "cows@aa.io")
  ryan = User.create!(username: "will_climb_rocks", age: 11, political_affiliation: "Ravenclaw" , email: "boulderz@aa.io")
  charlos = User.create!(username: "charlos_gets_buckets", age: 11, political_affiliation: "Gryffindow", email: "ballin@aa.io")
  elliot = User.create!(username: "all_knowing_elliot", age: 11, political_affiliation: "Gryffindor", email: "those_are_teef@aa.io")
  
  hagrid = User.create!(username: 'Rubeus Hagrid', age: 45, political_affiliation: "Giant", email: "hagrid@hogwarts.io")
  harry = User.create!(username: 'Harry Potter', age: 11, political_affiliation: "Gryffindor", email: "harry@hogwarts.io")
  hermione = User.create!(username: 'Hermione Granger', age: 11, political_affiliation: "Gryffindor", email: "hermione@hogwarts.io")
  ron = User.create!(username: 'Ron Weasley', age: 11, political_affiliation: "Gryffindor", email: "ron@hogwarts.io")
  dumbledore = User.create!(username: "Albus Dumbledore", age: 93, political_affiliation: "Headmaster", email: "dumbledore@hogwarts.io")
  draco = User.create!(username: "Draco Malfoy", age: 11, political_affiliation: "Slytherin", email: "draco@hogwarts.io")
  nimbus = User.create!(username: "Nimbus", age: 45, email: "brooms@nimbus.io")

  
  Chirp.destroy_all

  # Chirps
  chirp1 = Chirp.create!(author_id: hagrid.id, body: "You're a wizard, Elliot.")
  chirp2 = Chirp.create!(author_id: harry.id, body: "I solemnly swear I am up to no good.")

  chirp3 = Chirp.create!(author_id: hermione.id, body: "It’s wingardium leviOsa, not leviosAH.")
  chirp4 = Chirp.create!(author_id: hermione.id, body: "We could all have been killed or worse, expelled.")
  chirp5 = Chirp.create!(author_id: hermione.id, body: "Just because you have the emotional range of a teaspoon doesn’t mean we all have.")

  chirp6 = Chirp.create!(author_id: dumbledore.id, body: "Words are, in my not-so-humble opinion, our most inexhaustible source of magic.")
  chirp7 = Chirp.create!(author_id: dumbledore.id, body: "It takes a great deal of bravery to stand up to our enemies, but just as much to stand up to our friends.")
  chirp8 = Chirp.create!(author_id: dumbledore.id, body: "It is our choices, Elliot, that show what we truly are, far more than our abilities.")
  chirp9 = Chirp.create!(author_id: dumbledore.id, body: "Happiness can be found even in the darkest of times if only one remembers to turn on the light.")

  chirp10 = Chirp.create!(author_id: nimbus.id, body: "Nimbus 2000s are (quite literally) flying off the shelves - get them while they're hot!")
  chirp11 = Chirp.create!(author_id: nimbus.id, body: "Buy your broomstick from a brand you trust. Choose Nimbus.")
  chirp12 = Chirp.create!(author_id: nimbus.id, body: "If you're a seeker you'll love our new stick. Weave your way through the opponent with the best aerodynamics a broomstick has ever seen!")

  Like.destroy_all

  # Likes

  # Hagrid
  Like.create!(liker_id: hagrid.id, chirp_id: chirp3.id)
  Like.create!(liker_id: hagrid.id, chirp_id: chirp4.id)
  Like.create!(liker_id: hagrid.id, chirp_id: chirp5.id)
  Like.create!(liker_id: hagrid.id, chirp_id: chirp6.id)
  Like.create!(liker_id: dean.id, chirp_id: chirp7.id)
  Like.create!(liker_id: dean.id, chirp_id: chirp8.id)
  Like.create!(liker_id: dean.id, chirp_id: chirp9.id)

  # Harry
  Like.create!(liker_id: harry.id, chirp_id: chirp6.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp7.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp8.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp9.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp3.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp4.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp10.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp11.id)
  Like.create!(liker_id: harry.id, chirp_id: chirp12.id)


  # Hermione
  Like.create!(liker_id: hermione.id, chirp_id: chirp3.id)
  Like.create!(liker_id: hermione.id, chirp_id: chirp4.id)
  Like.create!(liker_id: hermione.id, chirp_id: chirp5.id)

  # Ron
  Like.create!(liker_id: ron.id, chirp_id: chirp3.id)
  Like.create!(liker_id: ryan.id, chirp_id: chirp10.id)

  # Dumbledore
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp3.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp4.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp5.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp6.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp7.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp8.id)
  Like.create!(liker_id: dumbledore.id, chirp_id: chirp9.id)

  # Draco
  Like.create!(liker_id: draco.id, chirp_id: chirp10.id)
  Like.create!(liker_id: charlos.id, chirp_id: chirp12.id)

  # Comments
  Comment.create(body: 'Wow! What a magnificent play on words!', author_id: angela.id, chirp_id: chirp10.id)
  Comment.create(body: 'The Nimbus 2000 is incredible - smoothest broom I\'ve ever flown on', author_id: alissa.id, chirp_id: chirp10.id)
  Comment.create(body: 'Bloody hell @harry, have you seen this.', author_id: joe.id, chirp_id: chirp10.id)
  Comment.create(body: 'I will pay you money not to sell this to Harry Potter', author_id: dean.id, chirp_id: chirp10.id)
  Comment.create(body: 'What a knowitall!', author_id: charlos.id, chirp_id: chirp3.id)




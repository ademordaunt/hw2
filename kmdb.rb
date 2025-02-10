# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Role.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Generate models and tables, according to the domain model.
# TODO!


# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# Create the studio.
warner = Studio.create(name: "Warner Bros.")

# Create the movies.
batman_begins = Movie.create(
  title: "Batman Begins",
  year_released: 2005,
  rated: "PG-13",
  studio_id: warner.id
)

dark_knight = Movie.create(
  title: "The Dark Knight",
  year_released: 2008,
  rated: "PG-13",
  studio_id: warner.id
)

dark_knight_rises = Movie.create(
  title: "The Dark Knight Rises",
  year_released: 2012,
  rated: "PG-13",
  studio_id: warner.id
)

# Create the actors.
actor1  = Actor.create(name: "Christian Bale")
actor2  = Actor.create(name: "Michael Caine")
actor3  = Actor.create(name: "Liam Neeson")
actor4  = Actor.create(name: "Katie Holmes")
actor5  = Actor.create(name: "Gary Oldman")
actor6  = Actor.create(name: "Heath Ledger")
actor7  = Actor.create(name: "Aaron Eckhart")
actor8  = Actor.create(name: "Maggie Gyllenhaal")
actor9  = Actor.create(name: "Tom Hardy")
actor10 = Actor.create(name: "Joseph Gordon-Levitt")
actor11 = Actor.create(name: "Anne Hathaway")

# Create roles for "Batman Begins"
Role.create(movie_id: batman_begins.id, actor_id: actor1.id, character_name: "Bruce Wayne")
Role.create(movie_id: batman_begins.id, actor_id: actor2.id, character_name: "Alfred")
Role.create(movie_id: batman_begins.id, actor_id: actor3.id, character_name: "Ra's Al Ghul")
Role.create(movie_id: batman_begins.id, actor_id: actor4.id, character_name: "Rachel Dawes")
Role.create(movie_id: batman_begins.id, actor_id: actor5.id, character_name: "Commissioner Gordon")

# Create roles for "The Dark Knight"
Role.create(movie_id: dark_knight.id, actor_id: actor1.id, character_name: "Bruce Wayne")
Role.create(movie_id: dark_knight.id, actor_id: actor6.id, character_name: "Joker")
Role.create(movie_id: dark_knight.id, actor_id: actor7.id, character_name: "Harvey Dent")
Role.create(movie_id: dark_knight.id, actor_id: actor2.id, character_name: "Alfred")
Role.create(movie_id: dark_knight.id, actor_id: actor8.id, character_name: "Rachel Dawes")

# Create roles for "The Dark Knight Rises"
Role.create(movie_id: dark_knight_rises.id, actor_id: actor1.id, character_name: "Bruce Wayne")
Role.create(movie_id: dark_knight_rises.id, actor_id: actor5.id, character_name: "Commissioner Gordon")
Role.create(movie_id: dark_knight_rises.id, actor_id: actor9.id, character_name: "Bane")
Role.create(movie_id: dark_knight_rises.id, actor_id: actor10.id, character_name: "John Blake")
Role.create(movie_id: dark_knight_rises.id, actor_id: actor11.id, character_name: "Selina Kyle")


# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

Movie.all.order(:year_released).each do |movie|
    # Find the associated studio record using the foreign key.
    studio = Studio.find(movie.studio_id)
    # Format the output with fixed-width columns.
    puts "#{movie.title.ljust(24)} #{movie.year_released.to_s.ljust(14)} #{movie.rated.ljust(6)} #{studio.name}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

Movie.all.order(:year_released).each do |movie|
    Role.where(movie_id: movie.id).each do |role|
      actor = Actor.find(role.actor_id)
      # Format the movie title (24 characters wide) and the actor name (22 characters wide).
      puts "#{movie.title.ljust(24)} #{actor.name.ljust(22)} #{role.character_name}"
    end
  end
  
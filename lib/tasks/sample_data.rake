namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobaz",
                       password_confirmation: "foobaz")
  admin.toggle!(:admin)

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all
  50.times do
    content = Faker::Lorem.sentence(5)
    users[2..8].each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users[2]
  followed_users = users[4..50]
  followers      = users[5..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end
require 'random_data'
# Create Users
5.times do
  User.create!(
    name:     RandomData.random_name,
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
    name:        RandomData.random_sentence,
    description: RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
  post = Post.create!(
    user:   users.sample,
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )

  post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
  rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
posts = Post.all

# Create Sponsored Posts
20.times do
  SponsoredPost.create!(
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph,
    price:  RandomData.random_integer
  )
end
sponsored_posts = SponsoredPost.all

# Create Comments
100.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

# Create Ads
50.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: 5
  )
end

# Create Questions
50.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
  )
end

admin = User.create!(
  name:       'Admin User',
  email:      'admin@example.com',
  password:   'helloworld',
  role:       'admin'
)

member = User.create!(
  name:       'Member User',
  email:      'member@example.com',
  password:   'helloworld'
)

# puts"#{Post.count} posts before find_or_create_by"
# Post.find_or_create_by!(title: "Unique Title", body: "Unique body")
# puts"#{Post.count} posts after find_or_create_by"

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
puts "#{Vote.count} votes created"

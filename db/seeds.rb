# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_OF_USERS=10
NUM_OF_PRODUCTS= 20
NUM_TAGS= 9
NUM_OF_VOTES = 500
Like.delete_all
Tagging.delete_all
Tag.delete_all
User.delete_all
Review.delete_all
Product.delete_all
Vote.delete_all

# NUM_OF_PRODUCTS.times do
#     created_at = Faker::Date.backward(days: 365*5)
#     p = Product.create({
#         title: Faker::Cannabis.strain,
#         description: Faker::Cannabis.health_benefit,
#         price: rand(400..500),
#         sale_price: rand(1..399),
#         created_at: created_at,
#         updated_at: created_at
#     })
# end
PASSWORD='con'
super_user= User.create(
    first_name: 'Ken',
    last_name:'Chukanit',
    email: 'chonlasek.c@gmail.com',
    password: PASSWORD,
    is_admin: true

)

NUM_OF_USERS.times do
    first_name= Faker::Name.first_name 
    last_name= Faker::Name.last_name 
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: PASSWORD
    )
end
users=User.all

NUM_TAGS.times do 
    Tag.create(
        name:Faker::Commerce.department
    )
end
tags=Tag.all

NUM_OF_PRODUCTS.times do
    created_at=Faker::Date.backward(days: 365*5)
   p=Product.create(
       title: Faker::Cannabis.strain,
       description: Faker::Cannabis.health_benefit,
       price: rand(400..500),
       sale_price: rand(1..399),
       created_at: created_at,
       updated_at: created_at,
       user: users.sample
   )

    if p.valid?
    p.reviews = rand(0..15).times.map do 
    r = Review.new(
            body: Faker::GreekPhilosophers.quote,
            rating: rand(1..5),
            user: users.sample,
            likers: users.shuffle.slice(0,rand(users.count)),
            )
    end
    p.tags = tags.shuffle.slice(0,rand(tags.count))
    
   end
end

reviews = Review.all

NUM_OF_VOTES.times do
v = Vote.create(
    user: users.sample,
    result: [true, false].sample,
    review: reviews.sample
)
end

reviews = Review.all
product = Product.all
review =Review.all

puts Cowsay.say("Created #{NUM_OF_PRODUCTS} products and #{NUM_OF_USERS} users!", :dragon)
puts Cowsay.say("Generated #{review.count} reviews.",:tux)
puts Cowsay.say("Generated #{users.count} answers.",:beavis)
puts Cowsay.say("Generated #{Like.count} likes.",:bunny)
puts Cowsay.say("Generated #{tags.count} tags.",:sheep)
puts Cowsay.say("Generated #{Vote.count} votes.",:frogs)
puts Cowsay.say("Login with  #{super_user.email} and password:#{PASSWORD}.",:koala)

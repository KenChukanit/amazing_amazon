# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_OF_USERS=5
NUM_OF_PRODUCTS=100

Product.destroy_all()
User.destroy_all()
Review.destroy_all()

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
    password: PASSWORD
)

10.times do
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



100.times do
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
        Review.new(
            body: Faker::GreekPhilosophers.quote,
            rating: rand(1..5),
            user: users.sample
            )
       end
   end
end

    

   

NUM_OF_USERS.times do
    User.create({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email
    })
end 

product = Product.all
review =Review.all

puts Cowsay.say("Created #{NUM_OF_PRODUCTS} products and #{NUM_OF_USERS} users!", :dragon)
puts Cowsay.say("Generated #{review.count} reviews.",:tux)
puts Cowsay.say("Generated #{users.count} answers.",:beavis)
puts Cowsay.say("Login with  #{super_user.email} and password:#{PASSWORD}.",:koala)
p
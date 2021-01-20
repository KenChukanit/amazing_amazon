# [Lab] Test Drive Dog Class
# Build a Dog Class following TDD principles. It should have the following method:

# give_bone 
#   method that takes a string (as an argument) which describes the bone size 
    #   (e.g. 'small', 'medium', 'large', etc) and returns the number of bones it currently owns. 
    # Test that the dog can take a maximum of 3 bones.
# eat_bone 
    # method that returns the last bone (string describing bone size) that was added. 
    # Test that the last bone was returned and that a bone was removed.
# bone_count 
    # method that returns the number of remaining bones the dog owns. Test that it returns the correct amount.
require 'minitest/autorun'

class Dog
        attr_accessor :name, :color, :bones
        def initialize(name, color)
            @name = name
            @color = color
            @bones = []
        end

        def give_bone(bone)
            bone_size = ["small","medium","large"]
            puts "This is a #{bone} bone"
            if @bones.length <3
                @bones.push(bone)
            else  
                puts "I cannot have more than three bones"
            end
        end

        def eat_bone
            last_bone  = @bones.pop
            puts "I am eating #{last_bone} bones and now I have #{@bones.length} left."
            last_bone
            @bones
        end

        def bone_count
            return @bones.length
        end
end

d = Dog.new('a','blue')

d.give_bone("big")
d.give_bone("long")
# bone = d.bones
# bone.length

# d.bone_count
# d.give_bone("small")
# d.give_bone("small")
# d.give_bone("big")
puts d.eat_bone
# d.give_bone("medium")
# d.bone_count
# d.bones.length

    describe Dog do
        describe '.give_bone' do
            # Test the number of bones it currently owns.
            it 'returns the number of bones it currently owns' do
                # given
                dog = Dog.new('a','red')
                dog1 = Dog.new('b','black')
                dog2 = Dog.new('c','pink')
                dog.give_bone('small')
                dog1.give_bone('medium')
                dog2.give_bone('large')
                bone  = dog.bones
                bone1 = dog1.bones
                bone2 = dog2.bones
                #then
                _(bone.length).must_equal(1)
                _(bone1.length).must_equal(1)
                _(bone2.length).must_equal(1)
            end
        end
        describe '.give_bone' do
            # Test that the dog can take a maximum of 3 bones
            it 'returns if the dog can have more than 3 bones' do
            # given
            dog = Dog.new('a','red')
        
            dog.give_bone('small')
            dog.give_bone('small')
            dog.give_bone('medium')
            dog.give_bone('large')
            bone  = dog.bones
            #then
            _(bone.length).must_equal(3)
            end
        end
        describe '.eat_bone' do
            # Test returns the last bone (string describing bone size) that was added
            # Test that the last bone was returned and that a bone was removed
            it 'returns the last bone and the last bone was returned 
            and that a bone was removed' do
            # given
            dog = Dog.new('a','red')
        
            dog.give_bone('small')
            dog.give_bone('small')
            dog.give_bone('medium')
            dog.eat_bone
            bone  = dog.bones
            #then
            _(dog.eat_bone).must_equal('small')
            _(bone.length).must_equal(2)

            end
        end

        describe '.bone_count' do
            # returns the number of remaining bones the dog owns. 
            it 'returns the correct amount' do
            # given
            dog = Dog.new('a','red')
        
            dog.give_bone('small')
            dog.give_bone('small')
            dog.give_bone('medium')
            
            #then
            _(dog.bone_count).must_equal(3)

            end
        end
       
    
    end




# Stas

#     require "minitest/autorun"
# class Dog
#   def initialize
#     @storage = []
#   end
#   def give_bone(bone)
#     if @storage.length >= 3
#       "I have too many bones"
#     else
#       @storage.push(bone)
#       @storage.length
#     end
#   end
#   def eat_bone
#     fed = @storage.pop
#     "Yummy! I ate a #{fed} bone!"
#   end
#   def bone_count
#     @storage.length
#   end
# end
# describe Dog do
#   describe ".give_bone" do
#     it "adding a bone to dog's storage" do
#       dog = Dog.new
#       dog.give_bone("Small")
#       _(dog.bone_count).must_equal(1)
#     end
#     describe ".eat_bone" do
#       it "returning the last bone given and taking it out of storage" do
#         dog = Dog.new
#         dog.give_bone("Small")
#         _(dog.eat_bone).must_equal("Yummy! I ate a Small bone!")
#         _(dog.bone_count).must_equal(0)
#       end
#     end
#     describe ".bone_count" do
#       it "return the number of bones a dog has" do
#         dog = Dog.new
#         dog.give_bone("Small")
#         dog.eat_bone
#         _(dog.bone_count).must_equal(0)
#       end
#     end
#   end
# end
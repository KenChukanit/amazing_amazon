require 'minitest/autorun'

# class AwesomeCookie < Minitest::Test
    class Student
        attr_accessor :first_name, :last_name, :score
        def initialize(first_name, last_name, score)
            @first_name  = first_name 
            @last_name = last_name 
            @score = score
        end

        def fullname
            @first_name + " " + @last_name
        end

        def grade
            score = @score

            result = case score
            when 0..40 then "F"
            when 41..50 then "D"
            when 51..60 then "C"    
            when 61..70 then "B"
            when 71..100 then "A"
            else "Invalid Score"
            end
            result
        end
    end



# end

s = Student.new('John','Snow',40)
puts s.fullname
puts s.grade  

describe "Student" do
    it 'when initialized with correct arguments' do
        first_name='Jon'
        last_name='Bond'
        score=79
        expect(Student.new(first_name,last_name,score))
                .must_be_kind_of(Student)
      end
    it 'retruns the concatenated string of first_name and last name' do
    # Given
    first_name='Jon'
    last_name='Bond'
    score=79
    std=Student.new(first_name,last_name,score)

    # When
    full_name=std.fullname

    # Then 
    _(full_name).must_equal("#{first_name} #{last_name}")
    end
    it 'returns A at score 95' do
    # Given
    first_name='Jon'
    last_name='Bond'
    score=95
    std=Student.new(first_name,last_name,score)

    gradeA= std.grade
    _(gradeA).must_equal('A')
    end
    it 'returns F at score 30' do
        # Given
        first_name='Jon'
        last_name='Bond'
        score=30
        std=Student.new(first_name,last_name,score)
    
        gradeA= std.grade
        _(gradeA).must_equal('F')
        end

end


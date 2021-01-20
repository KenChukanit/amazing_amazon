# Write a Circle class following TDD principles. Initialize the circle with a radius attribute. It should have the following 3 methods:

# diameter method that returns the diameter.
# area method that returns the area of the circle. Test with various circles that the area returned is correct.
# perimeter method that returns the length of circle's border (or perimeter). Test with various circles that the perimeter returned is correct.

require 'minitest/autorun'

class Circle
    attr_accessor :r
    def initialize(r)
        @r = r
    end

    def dimeter
        2 * @r
    end

    def area
        @r * @r * Math::PI 
    end

    def perimeter
        2 * Math::PI * @r
    end

end
    



describe Circle do
    describe '.dimeter' do
        it 'return calculated dimeter of the circle' do
            # Given
            circle = Circle.new(3)
            circle1 = Circle.new(4)
            circle2 = Circle.new(5)
            #when
            dimeter =circle.dimeter
            dimeter1 =circle1.dimeter
            dimeter2 =circle2.dimeter
            #then
            _(dimeter).must_equal(6)
            _(dimeter1).must_equal(8)
            _(dimeter2).must_equal(10)

        end
    end
    describe '.perimeter'do
        it 'return the calculated perimeter of the circle' do
            #given
            circle = Circle.new(3)
            circle1 = Circle.new(4)
            circle2 = Circle.new(5)
            #when
            perimeter = circle.perimeter
            perimeter1 = circle1.perimeter
            perimeter2 = circle2.perimeter
            #Then
            _(perimeter).must_equal(18.84955592153876)
            _(perimeter1).must_equal(25.132741228718345)
            _(perimeter2).must_equal(31.41592653589793)
        end
    end 
    describe '.area' do
        it 'return the calculated area of the circle' do
            # given
            circle = Circle.new(3)
            circle1 = Circle.new(4)
            circle2 = Circle.new(5)
            #when
            area = circle.area
            area1 = circle1.area
            area2 = circle2.area
            #then
            _(area).must_equal(28.274333882308138)
            _(area1).must_equal(50.26548245743669)
            _(area2).must_equal(78.53981633974483)
        end
    end

end
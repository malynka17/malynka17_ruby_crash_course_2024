#!/usr/bin/ruby

require 'date'

class Student
  attr_accessor :name, :surname, :birthDate
  @@students = []

  def self.students
    @@students
  end

  def initialize(name, surname, birthdate)
    raise ArgumentError, "Birthdate should be in past"  if birthdate > Date.today

    @name = name
    @surname = surname
    @birthDate = birthdate
  end

  def ==(student)
    return ( @name == student.name && @surname == student.surname && @birthDate == student.birthDate)
  end

  def calculate_age()
    years = Date.today.year - self.birthDate.year
    if self.birthDate.month == Date.today.month
      years -= self.birthDate.day > Date.today.day ? 1 : 0
    else
      years -= self.birthDate.month > Date.today.month ?  1 : 0
    end

    return years
  end

  def add_student() 
    isNew = true

    unless @@students.empty?
      for x in @@students
        if x == self 
          isNew = false
        break
        end
      end
    end  
    (@@students << self ) if isNew
  end

  def remove_student()
    @@students.delete(self)
  end

  def self.get_students_by_name(name)
    list = []
    @@students.each do |x|
      list << x if x.name == name
    end
    return list
  end

  def self.get_students_by_age(age)
    list = []
    @@students.each do |x|
      list << x if x.calculate_age() == age
    end
    return list
  end

end




# #test #today is 2024-11-03
# puts "start"

# s1 = Student.new("Andrew", "Smith", Date.new(2002, 06, 12))
# s1_copy = s1 #to check if the same student can be added twice
# s2 = Student.new("Anna", "Johns", Date.new(2002, 05, 14))
# s3 = Student.new("Lara", "Croft", Date.new(2000, 11, 20))

# puts " "
# puts "create student from future"
# #check if student, who will be born in future, can be added
# begin 
#   s4 = Student.new("Stephan", "Pryanyk", Date.new(2040, 01, 01))
# rescue ArgumentError => e
#   puts "Error msg: #{e.message}"
# end


# puts "Add the same student again"
# s1.add_student()

# puts "Add other"
# s2.add_student()
# s3.add_student()

# puts "try to add double"

# s1_copy.add_student()
# s1.add_student()

# puts ' '
# Student.students.each{|s| p "Student #{s.name} #{s.surname}, age: #{s.calculate_age()}"}

# puts ' '
# puts "students, who is 22"
# student_age_22  = Student.get_students_by_age(22)
# student_age_22.each{|s| p "Student #{s.name} #{s.surname}, age: #{s.calculate_age()}"}

# puts ' '
# puts "students with name 'Lara'"
# student_name_Lara = Student.get_students_by_name("Lara")
# student_name_Lara.each{|s| p "Student #{s.name} #{s.surname}, age: #{s.calculate_age()}"}
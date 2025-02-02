class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values in accordance with the key/value pairs of the hash
    # Use the #send method to achieve this. 
    
    student_hash.each {|k,v| self.send(("#{k}="), v)}
    @@all << self
  end


  # This class method should take in an array of hashes. 
  # Call Student.create_from_collection with the return value of the Scraper.scrape_index_page method as the argument.
  # The method (#create_from_collection) should iterate over the array of hashes and create a new individual student using each hash. 
 
  def self.create_from_collection(students_array)
    students_array.each {|student_hash| self.new(student_hash)}
  end


# This instance method should take in a hash whose key/value pairs describe additional attributes of an individual student.
# Call student.add_student_attributes with the return value of the Scraper.scrape_profile_page method as the argument.
# method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
# The return value of this method should be the student itself. Use the self keyword.

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k,v| self.send(("#{k}="), v)}
  end

  def self.all
    @@all
  end
end


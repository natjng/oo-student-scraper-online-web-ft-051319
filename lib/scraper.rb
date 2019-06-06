require 'open-uri'
require 'pry'

class Scraper

# take in an argument of the URL of the index page
# the URL will be "./fixtures/student-site/index.html". 
# It should use Nokogiri and Open-URI to access that page. 
# The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url
# => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}, 
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "students/joe-jonas.html"}
# ]

  def self.scrape_index_page(index_url)
    html = open(index_url)
    student_site = Nokogiri::HTML(html)
    students = []
    student_site.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        url = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: url}
      end
    end
    students
  end


# take in an argument of a student's profile URL. 
# It should use Nokogiri and Open-URI to access that page. 
# The return value of this method should be a hash in which the key/value pairs describe an individual student. 
# Some students dont have a twitter or some other social link. Be sure to be able to handle that.
  # => {:twitter=>"http://twitter.com/flatironschool",
  #     :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #     :github=>"https://github.com/learn-co,
  #     :blog=>"http://flatironschool.com",
  #     :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #     :bio=> "I'm a school"
  #   }

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student = {}
    links = student_profile.css("div.social-icon-container a").map{|link| link.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = student_profile.css("div.profile-quote").text if student_profile.css("div.profile-quote")
    student[:bio] = student_profile.css("div.description-holder p").text if student_profile.css("div.description-holder p")
    student
  end

end


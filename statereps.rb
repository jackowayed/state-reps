#!/usr/bin/env ruby
require 'person.rb'
require 'net/http'
require 'uri'

def spacesToPlus(str)
  str = str.to_s
  arr = str.split(" ")
  str = ""
  arr.each{|x|
    str+=x
    str+="+"
  }
  str = str[0,str.length-1] if str.include?("+")
  return str
end

def spacesToHTML(str)
  str = str.to_s
  arr = str.split(" ")
  str = ""
  arr.each{|x|
    str+=x
    str+="&nbsp;"
  }
  str = str[0,str.length-1] if str.include?("+")
  return str
end




#format for files: Name \t Address \t City \t State \t Zip9 \t SD \t RD

def putPeople(people)
  out = File.new("uufn2.txt", "w")
  people.each{|x|
    str = ""
    str<< x.name if x.name
    str<< "\t"
    str<< x.address if x.address
    str<< "\t"
    str<< x.city if x.city
    str<< "\t"
    str<< x.state if x.state
    str<< "\t"
    str<< x.zip9 if x.zip9
    str<< "\t"
    str<< x.sd if x.sd
    str<< "\t"
    str<< x.rd if x.rd
    out<< str
    out<< "\n"
  }
  out.close
end



def getZip9()

  #POST = "digg.com"
  #PORT = 80
  

  
  #Net::HTTP.start(HOST, PORT) do |http|
  people.each{|x|
#  x = Person.new
    #  x.address="112 Great Circle Rd"
    #  x.city="Newark"
    #  x.state="DE"
    
    
    #request = Net::HTTP::Post.new(URI2,{"address1"=> x.address, "city"=> x.city, "state"=> x.state})
    #  request = Net::HTTP::Post.new(URI2, {"address2" => "112+Great+Circle+Rd", "city" => "Newark", "state" => "DE", "address1" => "", "zip5" => "", "visited" => "1", "pagenumber" => "0", "firmname"=>"", "urbanization" => "", "submit.x" => "0", "sumbit.y" => "0", "submit" => "Find+ZIP+Code"})
    
    
    
    #    uri2 = "/zip4/zcl_0_results.jsp?visited=1&pagenumber=0&firmname=&address2=#{spacesToPlus(x.address).upcase}&address1=&city=#{spacesToPlus(x.city).upcase}&state=#{spacesToPlus(x.state).upcase}&urbanization=&zip5=&submit.x=0&submit.y=0&submit=Find+ZIP+Code"
    #  request = Net::HTTP::Get.new(uri2)
    #    response = http.request(request)
    #response = Net::HTTP.get(URI.parse("zip4.usps.com/zip4/zcl_0_results.jsp?visited=1&pagenumber=0&firmname=&address2=#{spacesToPlus(x.address).upcase}&address1=&city=#{spacesToPlus(x.city).upcase}&state=#{spacesToPlus(x.state).upcase}&urbanization=&zip5=&submit.x=0&submit.y=0&submit=Find+ZIP+Code"))
    
    
    
    #page = Net::HTTP.post_form(URI.parse("zip4.usps.com/zip4/zcl_0_results.jsp"), {"address1"=> x.address, "city"=> x.city, "state"=> x.state})
    #uri2 = "/zip4/zcl_0_results.jsp?visited=1&pagenumber=0&firmname=&address2=#{spacesToPlus(x.address).upcase}&address1=&city=#{spacesToPlus(x.city).upcase}&state=#{spacesToPlus(x.state).upcase}&urbanization=&zip5=&submit.x=0&submit.y=0&submit=Find+ZIP+Code"
    #uri2 = "/popular/24hours"
    
    
    url = URI.parse("http://zip4.usps.com/zip4/zcl_0_results.jsp?visited=1&pagenumber=0&firmname=&address2=#{spacesToPlus(x.address).upcase}&address1=&city=#{spacesToPlus(x.city).upcase}&state=#{spacesToPlus(x.state).upcase}&urbanization=&zip5=&submit.x=0&submit.y=0&submit=Find+ZIP+Code")
    #puts url
    response = Net::HTTP.get(url)
    
    page = response.to_s
    page = page[31400..-1]
    #puts page
    #regex = /#{spacesToHTML(x.city)}&nbsp;#{spacesToHTML(x.state)}&nbsp;\d\d\d\d\d-\d\d\d\d/i
    regex = /\d\d\d\d\d-\d\d\d\d/
    #regex = /Newark&nbsp;DE&nbsp;&nbsp;19711-2334/i
    #regex = /<br \/>/
    #puts regex
    #zipspot = (/#{spacesToHTML(x.address).upcase}#{spacesToHTML(x.city)}&nbsp;#{spacesToHTML(x.state)}&nbsp;\d\d\d\d\d-\d\d\d\d/ =~ page)
    zipspot = regex=~page
    zip = page[zipspot,10] if (zipspot)
    #puts zip
    x.zip9 = zip if zip
    
    
    #thanks to http://snakesgemscoffee.blogspot.com/2007/03/twittering-around.html
  }
  #end
  
#  peoplestr = ""
#  people.each{|x|
#    peoplestr << x.writeOut()
#    peoplestr << "\n"
#  }
  #puts peoplestr
 
  putPeople() 
  

end



def getReps(people)
  people.each{|x|
#  x = Person.new
#  x.zip9 = "19711-2334"
  
    url = URI.parse("http://www.votesmart.org/search.php?search=#{x.zip9}")
    response = Net::HTTP.get(url);
    spot = /State House/ =~ response
#    puts spot
    response = response[spot..-1] if spot
    regex = /\d+/
    regex =~ response
    x.rd = $& if spot
    spot = /State Senate/ =~response
    response = response[spot..-1] if spot
    regex =~ response 
    x.sd = $& if spot
    
  }
#  puts x.sd
#  puts x.rd
  putPeople(people)
end

#main


peoplestr = (File.readlines ARGV[0])
people = []
peoplestr.each{|x|
  p = Person.new
  p.readIn(x)
  people << p
}
  
getReps(people)

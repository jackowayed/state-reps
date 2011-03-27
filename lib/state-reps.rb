#!/usr/bin/env ruby

require 'rubygems'
require 'httparty'

class StateReps
  def zip_9(person)
    begin
      url = URI.parse("http://zip4.usps.com/zip4/zcl_0_results.jsp?visited=1&pagenumber=0&firmname=&address2=#{spacesToPlus(person[:address]).upcase}&address1=&city=#{spacesToPlus(person[:city]).upcase}&state=#{spacesToPlus(person[:state]).upcase}&urbanization=&zip5=&submit.x=0&submit.y=0&submit=Find+ZIP+Code")
      #puts url
      response = Net::HTTP.get(url)
      
      page = response.to_s
      page = page[32000..-1]
      #puts page
      #regex = /#{spacesToHTML(person.city)}&nbsp;#{spacesToHTML(person.state)}&nbsp;\d\d\d\d\d-\d\d\d\d/i
      regex = /\d\d\d\d\d-\d\d\d\d/
      #regex = /Newark&nbsp;DE&nbsp;&nbsp;19711-2334/i
      #regex = /<br \/>/
      #puts regex
      #zipspot = (/#{spacesToHTML(person.address).upcase}#{spacesToHTML(person.city)}&nbsp;#{spacesToHTML(x.state)}&nbsp;\d\d\d\d\d-\d\d\d\d/ =~ page)
      zipspot = regex=~page
      zip = page[zipspot,10] if (zipspot)
      #puts zip
      zip
    rescue
      puts $!
      puts person.name
    end
  end
end

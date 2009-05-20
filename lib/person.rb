class Person
  attr_accessor :name, :address, :city, :state, :zip9, :sd, :rd
  
  @name = ""
  @address = ""
  @city = ""
  @state = ""
  @zip9 = ""
  @sd = ""
  @rd = ""

  @@senators = [nil]
  @@senators[1] = {:name => 'Harris B McDowell', :phone => '302-656-2921'}
  @@senators[2] = {:name => 'Margaret Rose Henry', :phone => '302-425-4148'}
  @@senators[3] = {:name => 'Robert Marshall', :phone => '302-656-7261'}
  @@senators[4] = {:name => 'Michael S Katz', :phone => '302-731-1190'}
  @@senators[5] = {:name => 'Catherine Cloutier', :phone => '302-477-0554'}
  @@senators[6] = {:name => 'Liane Sorenson', :phone => '302-234-3303'}
  @@senators[7] = {:name => 'Patricia Blevins', :phone => '302-994-3501'}
  @@senators[8] = {:name => 'David Sokola', :phone => '302-239-2193'}
  @@senators[9] = {:name => 'Karen E Peterson', :phone => '302-999-7522'}
  @@senators[10] = {:name => 'Bethany Hall-Long', :phone => '302-378-8386'}
  @@senators[11] = {:name => 'Anthony J DeLuca', :phone => '302-737-4929'}
  @@senators[12] = {:name => 'Dorinda A Connor', :phone => '302-328-8944'}
  @@senators[13] = {:name => 'David B McBride', :phone => '302-322-6100'}
  @@senators[14] = {:name => 'Bruce Ennis', :phone => '302-653-7566'}
  @@senators[15] = {:name => 'Nancy Cook', :phone => '302-653-8725'}
  @@senators[16] = {:name => 'Colin Bonini', :phone => '302-678-5548'}
  @@senators[17] = {:name => 'Brian J Bushweller', :phone => '302-674-5442'}
  @@senators[18] = {:name => 'Gary Simpson', :phone => '302-422-3460'}
  @@senators[19] = {:name => 'Thurman Adams', :phone => '302-337-8281'}
  @@senators[20] = {:name => 'George H Bunting', :phone => '302-539-2229'}
  @@senators[21] = {:name => 'Robert Venables', :phone => '302-875-7826'}


  def readIn(str)
    arr=str.chomp.split("\t")
    @name = arr[0].to_s.chomp
    @address = arr[1].to_s.chomp
    @city = arr[2].to_s.chomp
    @state = arr[3].to_s.chomp
    @zip9 = arr[4].to_s.chomp
    @SD = arr[5].to_s.chomp
    @RD = arr[6].to_s.chomp
  end
  
  def writeOut()
    str = ""
    if (@name)
      str+=@name
      str+="\t"
    end
    if (@address)
      str+=@address
      str+="\t"
    end
    if (@city)
      str+=@city
      str+="\t"
    end
    if (@state)
      str+=@state
      str+="\t"
    end
    if (@zip9)
      str+=@zip9
      str+="\t"
    end
    if (@sd)
      str+=@sd
      str+="\t"
    end
    if (@rd)
      str+=@rd
    end
    return str.chomp;
  end
  def to_s
    self.writeOut
  end
  def set_reps
    r = reps self
    self.rd = r[:rd]
    self.sd = r[:sd]
    r
  end
  def senator
    @senator ||= @@senators[self.sd.to_i]
  end
  def senator_phone
    @senator_phone ||= senator[:phone]
  end
  def senator_name
    @senator_name ||= senator[:name]
  end
  def full_address
    [self.address, self.city, self.state] * ', '
  end
end

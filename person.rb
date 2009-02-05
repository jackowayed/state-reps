class Person
  attr_accessor :name, :address, :city, :state, :zip9, :sd, :rd
  
  @name = ""
  @address = ""
  @city = ""
  @state = ""
  @zip9 = ""
  @sd = ""
  @rd = ""

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
end

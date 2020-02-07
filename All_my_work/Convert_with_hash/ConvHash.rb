require 'json'

class Convert
  attr_accessor :file_name, :ass_mass_data

  def initialize(file_name = "World")
    @file_name = file_name.to_s
    @ass_mass_data = {}
    @done_data = ""
  end

  def read_file_data
    if @file_name.nil?
      puts "File's name is empty"
    else
      file = File.open(@file_name)
      contexct_name = file.gets.to_s.split(',')
      contexct_name.each do |x|
        @ass_mass_data[x] = []
      end
      while(contexct_value = file.gets.to_s.split(','))
        i = 0
        @ass_mass_data.values.each do |value|
          value.push(contexct_value[i])
          i++
        end
      end
      file.close
    end
  end


  def conv_data_to_json
    if @ass_mass_data.nil?
       puts "file data is empty"
    else
       @ass_mass_data = @ass_mass_data.to_json
    end
  end

  def write_new_data
    if @ass_mass_data.nil?
       puts "Data is empty after convert to json"
    else
       file = File.new("#{ARGV[0].split('.')[0]}.json","w")
       file.puts(@ass_mass_data)
       file.close
    end
  end

end

 if __FILE__ == $0
   if ARGV.length != 1
       puts "We need exactly one parameter. The name of a file."
   else
     con = Convert.new(ARGV[0])
     con.read_file_data
     con.conv_data_to_json
     con.write_new_data
   end
 end
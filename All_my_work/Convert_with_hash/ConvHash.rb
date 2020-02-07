require 'json'
require 'smarter_csv'
require 'yaml'

class Convert
  attr_accessor :file_name, :ass_mass_data, :new_data_1, :new_data_2

  def initialize(file_name = "World")
    @file_name = file_name.to_s
    @ass_mass_data = {}
    @done_data = ""
  end

  def read_file_data
    if @file_name.nil?
      puts "File's name is empty"
    else
      all_data_csv = (SmarterCSV.process(@file_name)rescue nil)
      if(all_data_csv.nil?)
        puts "There isn't #{ARGV[0]}"
      else
      all_data_csv.each_with_index { |val, number|
        if(number==0)
          val.keys.each{ |key|
            @ass_mass_data[key] = []
          }
        end
        val.each{ |key, value|
        @ass_mass_data[key] << value
        }
      }
      end
    end
  end

  def conv_data_to_json
    if @ass_mass_data.empty?
       puts "file data is empty"
    else
       @new_data_1 = @ass_mass_data.to_json
    end
  end

  def write_new_data_json
    if @ass_mass_data.empty?
       puts "Data is empty after convert to json"
    else
       file = File.new("#{ARGV[0].split('.')[0]}.json","w")
       file.puts(@new_data_1)
       file.close
    end
  end

  def conv_data_to_yaml
    if @ass_mass_data.empty?
       puts "file data is empty"
    else
       @new_data_2 = @ass_mass_data.to_yaml
    end
  end

  def write_new_data_yaml
    if @ass_mass_data.empty?
      puts "Data is empty after convert to json"
   else
      file = File.new("#{ARGV[0].split('.')[0]}.yaml","w")
      file.puts(@new_data_2)
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
     con.write_new_data_json
     con.conv_data_to_yaml
     con.write_new_data_yaml
   end
 end
require 'open-uri'

require 'time'
    @all = []

#raises an exception if timeout is met
input_array=ARGV
system("sh mytv.sh \"#{input_array[0]}\";")

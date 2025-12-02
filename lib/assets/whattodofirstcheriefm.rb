require 'open-uri'

require 'time'
    @all = []

#raises an exception if timeout is met
input_array=ARGV
p ("Enregistrer la télé : sh mytv.sh \"#{input_array[0]}\";")
system("sh mytv.sh \"#{input_array[0]}\";")

require "open-uri"
require 'active_support/core_ext/hash'

require "nokogiri"
require "json"
require "time"
@input_array=ARGV
def every_so_many_seconds(seconds)
  last_tick = Time.now
  loop do
    sleep 0.1
    if Time.now - last_tick >= seconds
      last_tick += seconds
      yield
    end
  end
end
@time=Time.now.to_i.to_s

data_hash={"videos":[]}
@file='./sample-data'+@time+'.json'
@file1='./sample-data-cherie.json'
File.write(@file, JSON.dump(data_hash))

@a=("a".."z").to_a
def myfunc
  p Time.now
  file = File.read(@file)
  data_hash = JSON.parse(file)



  tv_json=Nokogiri::XML(URI.open(@input_array[0]))
  ##p tv_json
  #tv_json.children.each_with_index do |x,i|
  #  p "----"
  #  p i
  #  x.children.each_with_index do |y,z|
  #    p @a[z]

  #    p "~~~~"
  #    p y.text
  #    p "~~~~"
  #  end
  #  p "----"
  #end
  #tv_json.children[0].children[1].children.each_with_index do |x,i|
  #  p "----"

  #  x.children.each_with_index do |y,z|
  #    p "--------------------"
  #    p p"|"+@a[z]+i.to_s+"|"

  #    p "~~~~~~~~~~~~~~~~~~"
  #    p y
  #    p "~~~~"
  #  end
  #  p "----"
  #end

  #p tv_json.as_json
  @vids = tv_json.children[0].children[1].children
  #@vids.each_with_index do |wow,i|
  #  p i.to_s+wow.to_s
  #rescue
  #  p "oops"

  #end
  n=23
  all=[]
  15.times do

      title = @vids[n].children[1].text
      description =@vids[n].children[9].text
      link =@vids[n].children[3].text
      time = DateTime.parse(@vids[n].children[7].text.gsub(" GMT","")).to_time.localtime
      begin
        image = @vids[n].children[11].attributes["url"].value
      rescue
        image=""
      end
      n+=2
      currentvideo=({
                "title"=>title,
                      "description"=>description,
                            "filename"=>title,
                            "link"=>title,
                                  "image"=>image,
                                        "time"=>time
                                          })
      p currentvideo

      data_hash["videos"] << currentvideo if !data_hash["videos"].any?{|h| h["title"] == currentvideo["title"]}
      File.write(@file, JSON.dump(data_hash))
      File.write(@file1, JSON.dump(data_hash))
  rescue => e
    p e.message
    @vids[n].children.each_with_index do |y,zz|
      p zz
      p y.text
    rescue
      p "oops"
    end
    next
  end
rescue => e
  p e.message
  p "ouy"
end
myfunc()
every_so_many_seconds(90) do
  myfunc()

end


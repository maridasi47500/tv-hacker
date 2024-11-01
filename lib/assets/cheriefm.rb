require 'json'
require "open-uri"
require 'active_support/core_ext/hash'
require "nokogiri"
require "time"

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

@time = Time.now.to_i.to_s
data_hash = { "videos": [] }
@file = './sample-data' + @time + '.json'
@file1 = './sample-data-cherie.json'
File.write(@file, JSON.dump(data_hash))

def myfunc(input_file)
  p Time.now
  file = File.read(@file)
  data_hash = JSON.parse(file)
  tv_json = JSON.parse(File.read(input_file))

  tv_json["programme"].each_with_index do |vid, n|
    begin
      title = vid["title"]
      description = vid["desc"]
      link = vid["url"]
      time = DateTime.parse(vid["start"].gsub(" GMT", "")).to_time.localtime
      image = vid["icon"] || ""

      current_video = {
        "title" => title,
        "description" => description,
        "filename" => title,
        "link" => link,
        "image" => image,
        "time" => time
      }

      p current_video
      unless data_hash["videos"].any? { |h| h["title"] == current_video["title"] }
        data_hash["videos"] << current_video
        File.write(@file, JSON.dump(data_hash))
        File.write(@file1, JSON.dump(data_hash))
      end

    rescue => e
      p e.message
      vid.each_with_index do |y, zz|
        p zz
        p y rescue p "oops"
      end
      next
    end
  end
rescue => e
  p e.message
  p "ouy"
end

input_file = ARGV[0]
myfunc(input_file)
every_so_many_seconds(90) do
  myfunc(input_file)
end

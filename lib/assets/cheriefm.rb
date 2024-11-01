require "open-uri"
require 'active_support/core_ext/hash'
require "nokogiri"
require "json"
require "time"
#ruby bfm_tv_programs.rb 'URL_TO_BFM_TV_XML_FEED'

@input_array = ARGV

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

def myfunc
  p Time.now
  file = File.read(@file)
  data_hash = JSON.parse(file)
  tv_json = Nokogiri::XML(URI.open(@input_array[0]))

  @vids = tv_json.xpath('//programme')
  all = []

  @vids.each_with_index do |vid, n|
    begin
      title = vid.at_xpath('title').text
      description = vid.at_xpath('desc').text
      link = vid.at_xpath('url').text
      time = DateTime.parse(vid.at_xpath('start').text.gsub(" GMT", "")).to_time.localtime
      image = vid.at_xpath('icon/@src').to_s rescue ""
      
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
      vid.children.each_with_index do |y, zz|
        p zz
        p y.text rescue p "oops"
      end
      next
    end
  end
rescue => e
  p e.message
  p "ouy"
end

myfunc()
every_so_many_seconds(90) do
  myfunc()
end


require 'open-uri'
require 'active_record'
require 'json'
require 'timeout'
require 'nokogiri'

class Tv
  def initialize
    @date = "history/" + Time.new.to_s.scan(/\d+/).join[0..13]
    puts "Initialized TV Processing at #{@date}"
    @time_end = Time.new.localtime

    begin
      @doc = JSON.load(File.read("./sample-data-cherie.json"))
      @videos = @doc["videos"]
      puts "Loaded #{@videos.length} videos"
    rescue => e
      puts "Error loading JSON: #{e.message}"
      @videos = []
    end

    @all = []
    process_videos
  end

  def process_videos
    @videos.each_with_index do |video_data, n|
      title = video_data["title"]
      description = video_data["description"]
      video = title.parameterize
      time = DateTime.parse(video_data["time"]).to_time
      image = video_data["image"] rescue ""

      if video.length > 0
        @all.push({
          "video" => video,
          "title" => title,
          "description" => description,
          "image" => image,
          "time" => time
        })
      end
    rescue => e
      puts "Error processing video #{n}: #{e.message}"
    end
  end

  def get_all_videos
    @all
  end

  def write_files
    sorted_videos = @all.sort_by { |video| Time.parse(video["time"]).to_i }
    script_content = generate_script(sorted_videos)
    File.write("cut.rb", script_content)

    system("chmod +x cut.sh")
    system("mkdir -p #{@date}; mv cut.rb #{@date}; mv tv.mp4 #{@date}; (cd #{@date} && ruby cut.rb)")
  end

  def generate_script(videos)
    <<-SCRIPT
require 'time'
require 'open-uri'
require 'active_record'
require 'timeout'
require 'nokogiri'

def hack(nombresecondes)
  @time_end = Time.parse('#{@time_end}')
  @all = #{videos.to_json}
  temps = @all.reverse

  temps.each_with_index do |video, i|
    next if i == 0
    trim1 = calculate_trim_time(temps, i - 1)
    trim2 = calculate_trim_time(temps, i)

    if trim1 >= 0 && trim2 >= 0 && trim2 > trim1
      system("ffmpeg -ss #{trim1} -t #{trim2} -i tv.mp4 #{video['video']}.mp4")
    end
  end
end

def calculate_trim_time(videos, index)
  (@time_end - Time.parse(videos[index]['time'])).to_i
end

hack(0)
SCRIPT
  end
end

tv = Tv.new
tv.write_files

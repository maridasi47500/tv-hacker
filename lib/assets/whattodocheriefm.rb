require 'open-uri'
require 'active_record'
require 'json'
##
#
# utiliser cutmp3
# utiliser mid3v2, l'installer avec sudo apt-get install python3-mutagen

require 'timeout'
require 'nokogiri'
##
# ligne pour tester
# à mettre en commentaire plus tard
class Tv
  def initialize
    @date="history/"+Time.new.to_s.scan(/\d+/).join[0..13]
    p "my name".titleize
@time_end = Time.new.localtime
#wow=(`echo 'klyhgkjhg';mv file2.mp3 filemusic.mp3;`)
@doc = JSON.load(File.read("./sample-data-cherie.json"))
@videos = @doc["videos"]
p @videos.length
n = 0
@all=[]
@videos.length.times do 

  title = @videos[n]["title"]
  description = @videos[n]["description"]
  video = title.parameterize
  time = DateTime.parse(@videos[n]["time"]).to_time
  begin
  image = @videos[n]["image"]
  rescue
  image=""
  end
  n+=1
  p video
  if video.parameterize.length > 0
    @all.push({
      "video"=>video.parameterize,
        "title"=>title,
        "description"=>description,
        "image"=>image,
        "time"=>time
    })
  end
rescue => e
  p e.message
  p "erreur wow cherie fm radio chanson"
end
  return @all

  end
  def getallvideos
    @all
  end
  def ecritfichiers
@y=@all.map do |i|
j=i.to_a.map do |k,v|
  [k,v.to_s]
end
j.to_h
end
@all=@y.sort{|x|Time.parse(x["time"]).to_i}
req = "require 'time'\nrequire 'open-uri'\nrequire 'active_record'\nrequire 'timeout'\nrequire 'nokogiri'\n"
ok=("""cat <<EOF > cut.rb\n#{req}\n
def hack(nombresecondes)
\n@time_end=Time.parse('#{@time_end}')\n@all=#{@all.to_s}\n
temps = @all.reverse #.sort {|x,y| y['time'] <=> x['time']} #.pluck('time')
\n0.upto(temps.length - 2).each.with_index do |nmusiques,i|
\n  #if nmusiques == 0
\n  #  t2='00:00'
\n  #else
\n  tinsec = (@time_end - Time.parse(temps[nmusiques-1]['time']))# + 60.to_f + (nombresecondes.to_f)
\n  t=tinsec.to_s
\n  t2 = DateTime.strptime(t, '%s').strftime('%M:%S')
\n  #end
\n  tinsec = (@time_end - Time.parse(temps[nmusiques]['time']))# + 60.to_f + (nombresecondes.to_f)
\n  t=tinsec.to_s
\n  t1 = DateTime.strptime(t, '%s').strftime('%M:%S')
\n  #p @time_end
\n  #p temps[nmusiques]
\n  nom = temps[nmusiques]['video'].parameterize
\n  if nom.strip.length > 0
\n    cut=\"\"\"#!/bin/bash -x
\nfloat=\\\$(ffprobe -i tv.mp4 -show_entries format=duration -v quiet -of csv=\\\"p=0\\\")
\ndur=\\\${float%.*}
\ntrim=\\\$((dur - \#\{t2.split(\":\")[0].to_i*60+t2.split(\":\")[1].to_i\}))
\ntrim2=\\\$((dur - \#\{i == 0 ? 0 : (t1.split(\":\")[0].to_i*60+t1.split(\":\")[1].to_i)\}))
\nif [ \\\$trim -lt 0 ]; then
    \ntrim=0
\nfi
\nif [ \\\"\\\$trim2\\\" -gt \\\"\\\$trim\\\" ]; then
    \nif [ \\\"\\\$trim2\\\" -ge 0 ]; then
              \nif [ \\\"\\\$trim\\\" -ge 0 ]; then
                  \necho \\\"You are hacker\\\"
                  \necho \\\"\\\$trim2 > \\\$trim \\\"
                  \necho \\\"ffmpeg -ss \\\$trim -t \\\$trim2 -i tv.mp4 \#{nom}.mp4\\\"
                  \nffmpeg -ss \\\$trim -t \\\$trim2 -i tv.mp4 \#{nom}.mp4
              \nfi
    \nfi
\nfi
\"\"\"
\n    File.write(\"cut.sh\",cut)
\n    system(\"chmod +x cut.sh\")
\n    system(\"./cut.sh\")
\n  end
\nend
\nend
\nhack(0)
\n#mydate and time : lib/assets/history/#{@date}/
\nEOF\n\necho heeeey\nls\nmkdir -p #{@date}; mv cut.rb #{@date}; mv tv.mp4 #{@date};(cd #{@date} && ruby cut.rb);\n
"""); 
p (ok)
system(ok)
  end
end
@rad=Tv.new

@rad.ecritfichiers

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
  def hacker(timecut)

#puts 'It timed out!'



p @all.length
#p @dl
#listemusiques=[{"video"=>"The Weeknd - In your Eyes", "artist"=>"The Weeknd", "title"=>"In your Eyes", "time"=>"2020-10-12 14:54:01 +0200"}, {"video"=>"Lewis Capaldi - Before you go", "artist"=>"Lewis Capaldi", "title"=>"Before you go", "time"=>"2020-10-12 14:44:01 +0200"}, {"video"=>"P DIDDY - LAST NIGHT", "artist"=>"P DIDDY", "title"=>"LAST NIGHT", "time"=>"2020-10-12 14:40:01 +0200"}]
#
temps = @all.sort {|x,y| y["time"] <=> x["time"]} #.pluck('time')
0.upto(temps.length - 2) do |nmusiques|
  if nmusiques == 0
    t2="00:00"
  else
    tinsec = (@time_end - temps[nmusiques-1]["time"]) + 60.to_f + timecut.to_f
    t=tinsec.to_s
    t2 = DateTime.strptime(t, '%s').strftime('%M:%S')
  end
  tinsec = (@time_end - temps[nmusiques]["time"]) + 60.to_f + timecut.to_f
    t=tinsec.to_s
    t1 = DateTime.strptime(t, '%s').strftime('%M:%S')
    #p @time_end
    #p temps[nmusiques]
    nom = temps[nmusiques]["video"].parameterize
    #nom2 = temps[nmusiques][:video].parameterize+""
    cut="echo '-#{t1} -#{t2}'>timetable;cutmp3 -i filemusic.mp3 -f timetable -o #{nom};mid3v2 -a #{temps[nmusiques]["artist"].dump} -t #{temps[nmusiques]["title"].dump} #{nom}0001.mp3;"
    p cut
    system(cut)
    #puts("echo '-#{t1} -#{t2}'>timetable;cutmp3 -i filemusic.mp3 -f timetable -o #{nom};")
end
  end 
  def ecritfichiers
@y=@all.map do |i|
j=i.to_a.map do |k,v|
  [k,v.to_s]
end
j.to_h
end
@all=@y
req = "require 'time'\nrequire 'open-uri'\nrequire 'active_record'\nrequire 'timeout'\nrequire 'nokogiri'\n"
system(`cat <<EOF >cut.rb 
#{req}\n
def hack(nombresecondes)
\n@time_end=Time.parse('#{@time_end}')\n@all=#{@all.to_s}\n
temps = @all #.sort {|x,y| y['time'] <=> x['time']} #.pluck('time')
\n0.upto(temps.length - 2).each.with_index do |nmusiques,i|
\n  if nmusiques == 0
\n    t2='00:00'
\n  else
\n    tinsec = (@time_end - Time.parse(temps[nmusiques-1]['time'])) + 60.to_f + (nombresecondes.to_f)
\n    t=tinsec.to_s
\n    t2 = DateTime.strptime(t, '%s').strftime('%M:%S')
\n  end

\n    tinsec = (@time_end - Time.parse(temps[nmusiques]['time'])) + 60.to_f + (nombresecondes.to_f)
\n    t=tinsec.to_s
\n    t1 = DateTime.strptime(t, '%s').strftime('%M:%S')
\n    #p @time_end
\n    #p temps[nmusiques]
\n    nom = temps[nmusiques]['video'].parameterize
\n    if nom.strip.length > 0
\n      cut = "sh tele.sh; "
\n      wow="""dur=$(ffprobe -i tv.mp4 -show_entries format=duration -v quiet -of csv="p=0")
\n      \ntrim=$((#{i == 0 ? "" : "dur - "}#{t2.split(":")[0].to_i*60+t2.split(":")[1].to_i}))
\n      \ntrim2=$((dur - #{t1.split(":")[0].to_i*60+t1.split(":")[1].to_i}))
\n      \nffmpeg -t $trim -i tv.mp4 #{nom}.mp4
\n      """
\n      yourfile="tele.sh"
\n      File.open(yourfile, 'w') { |file| file.write(wow) }
\n      cut+="mid3v2 -a \#{temps[nmusiques]['artist'].dump} -t \#{temps[nmusiques]['title'].dump} \#{nom}.mp4;"
\n      system(cut)
\n    end
\nend
\nend
\nhack(-460)
\n#mydate and time : lib/assets/history/#{@date}/
\nEOF\nmkdir -p #{@date}; mv cut.rb #{@date}; mv tv.mp4 #{@date};(cd #{@date} && ruby cut.rb);`);
  end
end
@rad=Tv.new

@rad.ecritfichiers

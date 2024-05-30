cat <<EOF > cut.rb 

require 'time'
require 'open-uri'
require 'active_record'
require 'timeout'
require 'nokogiri'


def hack(nombresecondes)

@time_end=Time.parse('#{@time_end}')
@all=#{@all.to_s}

temps = @all #.sort {|x,y| y['time'] <=> x['time']} #.pluck('time')

0.upto(temps.length - 2).each.with_index do |nmusiques,i|

  if nmusiques == 0

    t2='00:00'

  else

    tinsec = (@time_end - Time.parse(temps[nmusiques-1]['time'])) + 60.to_f + (nombresecondes.to_f)

    t=tinsec.to_s

    t2 = DateTime.strptime(t, '%s').strftime('%M:%S')

  end

  tinsec = (@time_end - Time.parse(temps[nmusiques]['time'])) + 60.to_f + (nombresecondes.to_f)

  t=tinsec.to_s

  t1 = DateTime.strptime(t, '%s').strftime('%M:%S')

  #p @time_end

  #p temps[nmusiques]

  nom = temps[nmusiques]['video'].parameterize

  if nom.strip.length > 0

    #cut = "sh tele.sh; "

    cut="""dur=\$(ffprobe -i tv.mp4 -show_entries format=duration -v quiet -of csv="p=0")

    
trim=\$((#{i == 0 ? "" : "dur - "}#{t2.split(":")[0].to_i*60+t2.split(":")[1].to_i}))

    
trim2=\$((dur - #{t1.split(":")[0].to_i*60+t1.split(":")[1].to_i}))

    
ffmpeg -t $trim -i tv.mp4 #{nom}.mp4

    
mid3v2 -a #{temps[nmusiques]['title'].dump} -t #{temps[nmusiques]['title'].dump} #{nom}.mp4;"

    """

    #yourfile="tele.sh"

    #File.open(yourfile, 'w') { |file| file.write(wow) }

    #cut+="mid3v2 -a #{temps[nmusiques]['title'].dump} -t #{temps[nmusiques]['title'].dump} #{nom}.mp4;"

    system(cut)

  end

end

end

hack(-460)

#mydate and time : lib/assets/history/history/20240530085823/

EOF

echo heeeey
ls
mkdir -p history/20240530085823; mv cut.rb history/20240530085823; mv tv.mp4 history/20240530085823;(cd history/20240530085823 && ruby cut.rb);


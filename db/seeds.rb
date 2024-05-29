#lance le script dans lib/assets nomm script.sh

#ensuite

#system("mkdir public/uploads")
Dir.glob(Rails.root.to_s+"/lib/assets/history/**/**.mp4").select{|h|!h.include?("tv.mp4")}.each do |x|
  system("mkdir public/uploads; mv \"#{x}\" public/uploads/")
end
xxxxx=Dir.glob(Rails.root.to_s+"/lib/assets/history/**/cut.rb").select do |u|
  h=u.split("history")[1]
  p h[1..4].to_i, h[5..6].to_i, h[7..8].to_i, h[9..10].to_i, h[11..12].to_i, h[13..14].to_i
  yy=DateTime.new(h[1..4].to_i, h[5..6].to_i, h[7..8].to_i, h[9..10].to_i, h[11..12].to_i, h[13..14].to_i)
  
  
  yy
rescue
  p "reerroi"
  false
end
p xxxxx
xxxxx.each do |x|
  p x
a=File.readlines(x)
mystr=(a.select{|h|h.include?("@all=")}[0].split(",").map{|j|j.include?('-0300') ? "}," : j}.join(",").gsub("{{","[{").gsub(",,",",")+"}]").gsub(",}","}").gsub("}}","}").gsub("@all=","").gsub("=>",":").gsub("}]\n}]", "}]")
p mystr


all=JSON.parse(mystr)

all.each do |j|


  p j
  s=Video.find_or_create_by(filename: j["filename"].parameterize, description: j["description"],link:j["link"],title: j["title"])
  s.update(image:(j['image'] and j["image"].length > 0 ? j["image"] : nil))
  end
end

end

h=File.readlines("public/uploads/fra.m3u")
y= h.index{|h|h.include?("Trace Urban")}
p y.to_i
k=h[(y.to_i+1)..].index{|j|j.include?("#EXT")}.to_i
p k
l=h.to_a
p y.is_a?(Integer)
z=1
(k+1).times do 
  x= l.delete_at(y)
  p x
  l.insert(z, x)
  z+=1
end
p l[0..10]
File.write("hey.rb", l.join(""))

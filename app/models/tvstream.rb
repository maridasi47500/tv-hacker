class Tvstream < ApplicationRecord
belongs_to :tv
after_create :heythere
after_update :heythere
def heythere
h=File.readlines("./public/uploads/#{self.mytv}")
y= h.index{|h|h.include?(self.firsttv.to_s)}
p y.to_i
if y > 0
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
File.write("./public/uploads/#{self.mytv}", l.join(""))
end

end

def mytv=(uploaded_io)
File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  file.write(uploaded_io.read)
end
write_attribute(:mytv, uploaded_io.original_filename)
end
def mytv
read_attribute(:mytv)
end

end

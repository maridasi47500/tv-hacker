class Video < ApplicationRecord
  def track_list
    x=[
        {
              id: self.id,
                  title: self.title,
                      description: self.description,
                          image: (self.image or "https://source.unsplash.com/Qrspubmx6kE/640x360"),
                              path: "/uploads/"+self.filename+".mp4"
                                }
    ]
    x.to_json
  end
  def self.track_list
    xx=select("videos.*").to_a.shuffle.map do |x|
        {
              id: x.id,
                  title: x.title,
                      description: x.description,
                          image: (x.image or "https://source.unsplash.com/Qrspubmx6kE/640x360"),
                              path: "/uploads/"+x.filename+".mp4"
                                }
    end
    xx.to_json
  end
end

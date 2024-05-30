json.extract! video, :id, :title, :description, :filename, :link, :image, :tv_id, :created_at, :updated_at
json.url video_url(video, format: :json)

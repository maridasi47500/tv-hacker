require 'open-uri'
require 'zip'
require 'nokogiri'
require 'json'

# Download and extract the XML file
def download_and_extract_xml(url, xml_file, output_file)
  open(url) do |zip_file|
    Zip::File.open_buffer(zip_file.read) do |zip|
      zip.each do |entry|
        if entry.name == xml_file
          content = entry.get_input_stream.read
          process_bfm_tv(content, output_file)
          break
        end
      end
    end
  end
end

# Process BFM TV data and save to JSON
def process_bfm_tv(xml_content, output_file)
  data_hash = { "programme": [] }
  tv_json = Nokogiri::XML(xml_content)
  @vids = tv_json.xpath('//programme[starts-with(channel, "BFM TV")]')

  @vids.each do |vid|
    title = vid.at_xpath('title').text
    description = vid.at_xpath('desc').text
    time = DateTime.parse(vid.at_xpath('start').text).to_time

    current_video = {
      "title" => title,
      "description" => description,
      "time" => time
    }

    data_hash[:videos] << current_video
  end

  File.write(output_file, JSON.pretty_generate(data_hash))
  puts "BFM TV program data saved to #{output_file}"
end

url = "https://xmltvfr.fr/xmltv/xmltv.zip"
xml_file = "xmltv.xml"
output_file = "bfm_tv_program.json"
download_and_extract_xml(url, xml_file, output_file)

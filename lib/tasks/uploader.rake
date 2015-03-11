SOURCE_FILE = 'contacts.csv'

namespace :cs do
  task :parse => :environment do
    File.open(SOURCE_FILE, 'r') do |file|
      file.readline

      file.each_line do |line|
        contact_attributes = {}
        line.split(',').each_with_index do |col, col_count|
          contact_attributes[ headers[col_count] ] = col
        end
        p contact_attributes
        Contact.create contact_attributes

        p '----------------------'
      end

    end
  end

  task :fill_locations => :environment do
    GEOCODE_URL = 'http://maps.googleapis.com/maps/api/geocode/json?address='

    Contact.all.each do |contact|
      if contact.latitude.nil? || contact.longitude.nil?
        url = URI(GEOCODE_URL + "#{URI.encode(contact.country)}+#{URI.encode(contact.city)}")
        begin
          geocode = JSON.parse Net::HTTP.get(url)
          location = geocode['results'][0]['geometry']['location']
          contact.update_attributes :latitude => location['lat'], :longitude => location['lng']
        rescue
          rescue_url = URI(GEOCODE_URL + "#{URI.encode(contact.country)}")
          geocode = JSON.parse Net::HTTP.get(rescue_url)
          location = geocode['results'][0]['geometry']['location']
          contact.update_attributes :latitude => location['lat'], :longitude => location['lng']
        end
      end
    end
  end
end

def headers
  ['name', 'country', 'city', 'sex', 'horoscope', 'career', 'hometown', 'birthday', 'introduction', 'hobbies', 'age']
end

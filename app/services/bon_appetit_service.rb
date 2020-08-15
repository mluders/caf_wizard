class BonAppetitService
  class << self
    def fetch_dayparts(cafe_uid:)
      r = HTTParty.get("https://legacy.cafebonappetit.com/api/2/menus?cafe=#{cafe_uid}")
      raw_json = JSON.parse(r.body())

      raw_dayparts = raw_json.dig('days', 0, 'cafes', "#{cafe_uid}", 'dayparts', 0) || []
      raw_items = raw_json['items']

      output = []

      raw_dayparts.each do |daypart|
        temp = {}
        temp['label'] = daypart['label'].titleize

        # Time conversion
        starttime = DateTime.strptime(daypart['starttime'], '%H:%M')
        endtime = DateTime.strptime(daypart['endtime'], '%H:%M')

        temp['starttime'] = starttime.strftime('%l:%M %p').lstrip
        temp['endtime'] = endtime.strftime('%l:%M %p').lstrip

        master_stations = {}

        daypart['stations'].each do |station|
          temp_stations = []
          station['items'].each do |item|
            next unless raw_items[item]['special'] == 1
            temp_stations << raw_items[item]['label'].titleize
            master_stations[station['label']] = temp_stations
          end
        end

        temp['stations'] = master_stations

        output << temp
      end

      output
    end
  end
end
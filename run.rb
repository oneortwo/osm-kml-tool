#!/usr/bin/env ruby

# http://www.overpass-api.de/api/xapi_meta?node[railway=subway_entrance][bbox=17.880146,59.210040,18.175404,59.412946]

OE_PATH = "/usr/local/Cellar/ruby/2.0.0-p247/bin/osmexport"
OUTPUT_DIR = "output"
TEMP_FILE = "temp.osm"
OXR_DIR = "oxr"
API = "http://www.overpass-api.de/api/xapi_meta?"
BBOX = "17.880146,59.210040,18.175404,59.412946"
ITEMS = [
			{ "filter" => "node[railway=subway_entrance]", "oxr" => "subway_entrance" }
		]


# prepare output dir
`rm -rf #{OUTPUT_DIR}`
`mkdir #{OUTPUT_DIR}`

ITEMS.each do |item|

	filter = item["filter"]
	oxr = item["oxr"]
	query = "#{API}#{filter}[bbox=#{BBOX}]"


	# download OSM file to temporary location
	`wget -O #{TEMP_FILE} #{query}`

	`#{OE_PATH} #{OXR_DIR}/#{oxr}.oxr #{TEMP_FILE} #{OUTPUT_DIR}/#{oxr}.kml`

	# remove temporary file
	`rm #{TEMP_FILE}`
end

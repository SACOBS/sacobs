# Cities
City.destroy_all

cities = ['East London', 'Port Alfred', 'Alexandria', 'Port Elizabeth', 'Jeffreys Bay', 'Humansdorp', 'Stormsriver', 'Plettenburg Bay', 'Knysna',
          'Sedgefield', 'Wilderness', 'George', 'Mossel Bay', 'Albertinia', 'Riversdale', 'Heidelburg', 'Swellendam', 'Riviersonderend', 'Caledon',
          'Grabouw', 'Somerset West', 'Cape Town']

cities.each { |city| City.find_or_create_by(name: city) }

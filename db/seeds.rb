# Cities
City.destroy_all

cities = ['East London','Port Alfred','Alexandria','Port Elizabeth','Jeffreys Bay','Humansdorp','Stormsriver','Plettenburg Bay','Knysna',
          'Sedgefield','Wilderness','George','Mossel Bay','Albertinia','Riversdale','Heidelburg','Swellendam','Riviersonderend','Caledon',
          'Grabouw','Somerset West','Cape Town']

cities.each {|city| City.find_or_create_by(name: city)}

# Routes
Route.destroy_all

## EL to CT
#el_to_ct = Route.create(start_city: City.find_by(name: 'East London' ),end_city: City.find_by(name: 'Cape Town'), distance: 1038, cost: 100)
#el_to_ct.connections.build(from_city: City.find_by(name: 'East London' ), to_city: City.find_by(name: 'Port Alfred' ), distance: 132 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Port Alfred' ), to_city: City.find_by(name: 'Alexandria' ), distance: 51 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Alexandria' ), to_city: City.find_by(name: 'Port Elizabeth' ), distance: 105 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Port Elizabeth' ), to_city: City.find_by(name: 'Jeffreys Bay' ), distance: 75 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Jeffreys Bay' ), to_city: City.find_by(name: 'Humansdorp' ), distance: 14 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Humansdorp' ), to_city: City.find_by(name: 'Stormsriver' ), distance: 98 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Stormsriver' ), to_city: City.find_by(name: 'Plettenburg Bay' ), distance: 55 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Plettenburg Bay' ), to_city: City.find_by(name: 'Knysna' ), distance: 34 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Knysna' ), to_city: City.find_by(name: 'Sedgefield' ), distance: 24 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Sedgefield' ), to_city: City.find_by(name: 'Wilderness' ), distance: 20 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Wilderness' ), to_city: City.find_by(name: 'George' ), distance: 16 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'George' ), to_city: City.find_by(name: 'Mossel Bay' ), distance: 51 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Mossel Bay' ), to_city: City.find_by(name: 'Albertinia' ), distance: 56 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Albertinia' ), to_city: City.find_by(name: 'Riversdale' ), distance: 40 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Riversdale' ), to_city: City.find_by(name: 'Heidelburg' ), distance: 32 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Heidelburg' ), to_city: City.find_by(name: 'Swellendam' ), distance: 54 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Swellendam' ), to_city: City.find_by(name: 'Riviersonderend' ), distance: 59 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Riviersonderend' ), to_city: City.find_by(name: 'Caledon' ), distance: 54 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Caledon' ), to_city: City.find_by(name: 'Grabouw' ), distance: 44 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Grabouw' ), to_city: City.find_by(name: 'Somerset West' ), distance: 22 )
#el_to_ct.connections.build(from_city: City.find_by(name: 'Somerset West' ), to_city: City.find_by(name: 'Cape Town' ), distance: 48 )
#el_to_ct.save!
#
## CT to EL
#ct_to_el = Route.create(end_city: City.find_by(name: 'East London' ), start_city: City.find_by(name: 'Cape Town'), distance: 1038, cost: 0)
#ct_to_el.connections.build(to_city: City.find_by(name: 'Somerset West' ), from_city: City.find_by(name: 'Cape Town' ), distance: 48 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Grabouw' ), from_city: City.find_by(name: 'Somerset West' ), distance: 22 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Caledon' ), from_city: City.find_by(name: 'Grabouw' ), distance: 44 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Riviersonderend' ), from_city: City.find_by(name: 'Caledon' ), distance: 54 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Swellendam' ), from_city: City.find_by(name: 'Riviersonderend' ), distance: 59 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Heidelburg' ), from_city: City.find_by(name: 'Swellendam' ), distance: 54 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Riversdale' ), from_city: City.find_by(name: 'Heidelburg' ), distance: 32 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Albertinia' ), from_city: City.find_by(name: 'Riversdale' ), distance: 40 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Mossel Bay' ), from_city: City.find_by(name: 'Albertinia' ), distance: 56 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'George' ), from_city: City.find_by(name: 'Mossel Bay' ), distance: 51 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Wilderness' ), from_city: City.find_by(name: 'George' ), distance: 16 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Sedgefield' ), from_city: City.find_by(name: 'Wilderness' ), distance: 20 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Knysna' ), from_city: City.find_by(name: 'Sedgefield' ), distance: 24 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Plettenburg Bay' ), from_city: City.find_by(name: 'Knysna' ), distance: 34 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Stormsriver' ), from_city: City.find_by(name: 'Plettenburg Bay' ), distance: 55 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Humansdorp' ), from_city: City.find_by(name: 'Stormsriver' ), distance: 98 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Jeffreys Bay' ), from_city: City.find_by(name: 'Humansdorp' ), distance: 14 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Port Elizabeth' ), from_city: City.find_by(name: 'Jeffreys Bay' ), distance: 75 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Alexandria' ), from_city: City.find_by(name: 'Port Elizabeth' ), distance: 105 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'Port Alfred' ), from_city: City.find_by(name: 'Alexandria' ), distance: 51 )
#ct_to_el.connections.build(to_city: City.find_by(name: 'East London' ), from_city: City.find_by(name: 'Port Alfred' ), distance: 132 )
#ct_to_el.save!

# PE to EL
pe_to_el = Route.create(end_city: City.find_by(name: 'East London' ), start_city: City.find_by(name: 'Port Elizabeth'), distance: 286, cost: 2000)
pe_to_el.connections.build(to_city: City.find_by(name: 'Alexandria' ), from_city: City.find_by(name: 'Port Elizabeth' ), distance: 105, percentage: 40 )
pe_to_el.connections.build(to_city: City.find_by(name: 'Port Alfred' ), from_city: City.find_by(name: 'Alexandria' ), distance: 51, percentage: 20 )
pe_to_el.connections.build(to_city: City.find_by(name: 'East London' ), from_city: City.find_by(name: 'Port Alfred' ), distance: 132, percentage: 40)
pe_to_el.save!

# EL to PE
el_to_pe = Route.create(start_city: City.find_by(name: 'East London' ),end_city: City.find_by(name: 'Port Elizabeth'), distance: 286, cost: 0)
el_to_pe.connections.build(from_city: City.find_by(name: 'East London' ), to_city: City.find_by(name: 'Port Alfred' ), distance: 132, percentage: 40 )
el_to_pe.connections.build(from_city: City.find_by(name: 'Port Alfred' ), to_city: City.find_by(name: 'Alexandria' ), distance: 51, percentage: 20 )
el_to_pe.connections.build(from_city: City.find_by(name: 'Alexandria' ), to_city: City.find_by(name: 'Port Elizabeth' ), distance: 105, percentage: 40 )
el_to_pe.save!
























































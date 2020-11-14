import csv
import psycopg2

#connecting to Amazon AWS database and manipulating tables with Python

#function to remove invalid (non-numeric) characters from zip codes etc
def manipulate(s):
	if(s==''): return '0'
	new_num = ''
	for i in s:
		if(i.isdigit()==True): new_num= new_num + i 
	return new_num


print "Connecting to database. . ."
engine = psycopg2.connect(
    database="...",
    user="...",
    password="...",
    host="....rds.amazonaws.com",
    port='####'
)
cur = engine.cursor()


# 1) fixing amenity ids

print "Fixing amenity ids. . ."

cur.execute('SELECT * FROM Amenity')
all = cur.fetchall()
all_amenities=all

amenity_readers = [csv.reader(open('data/boston_normalizedCSVs/amenity.csv','r'))
				  ,csv.reader(open('data/denver_normalizedCSVs/amenity.csv','r'))
				  ,csv.reader(open('data/portland_normalizedCSVs/amenity.csv','r'))]
amenity_writers = [csv.writer(open('data/output/amenityB_noduplicates.csv','wb'))
				  ,csv.writer(open('data/output/amenityD_noduplicates.csv','wb'))
				  ,csv.writer(open('data/output/amenityP_noduplicates.csv','wb'))]
li2amen_readers = [csv.reader(open('data/boston_normalizedCSVs/listing2amenity.csv','r'))
				  ,csv.reader(open('data/denver_normalizedCSVs/listing2amenity.csv','r'))
				  ,csv.reader(open('data/portland_normalizedCSVs/listing2amenity.csv','r'))]				  
li2amen_writers = [csv.writer(open('data/output/listing2amenityB_fixed.csv','wb'))
				  ,csv.writer(open('data/output/listing2amenityD_fixed.csv','wb'))
				  ,csv.writer(open('data/output/listing2amenityP_fixed.csv','wb'))]
				  
i = 0
for reader in amenity_readers:
	writer = amenity_writers[i]
	li2amen_reader = li2amen_readers[i]
	li2amen_writer = li2amen_writers[i]
	writer.writerow(('amenity_name','amenity_id'))
	li2amen_writer.writerow(('listing_id','amenity_id'))
	
	#skip the headers 
	next(reader)
	next(li2amen_reader)
	
	new_amenities = []
	listing_amenities = []
	#remove amenity_id (from listing2amenity) that doesn't belong to an amenity: 161
	for li2amen in li2amen_reader:
		if(li2amen[1]!='161'):
			listing_amenities.append(li2amen)
	amenity_counter = len(all_amenities) +1
	
	
	for new_amenity in reader:
		a = True
		old_id = new_amenity[0]
		new_id = 0
		for amenity in all_amenities:
			if(amenity[0].lower() == new_amenity[1].lower()): #if the names match
				a = False
				new_amenity[0]=amenity[1]
				new_id = amenity[1]
		if(a == True) : 
			new_id = amenity_counter
			new_amenity[0] = amenity_counter
			new_amenities.append((new_amenity[1],new_amenity[0]))
			all_amenities.append((new_amenity[1],new_amenity[0]))
		#update listing amenity list
		for li2amen in listing_amenities:
			if(li2amen[1]==old_id):	
				li2amen[1]= new_id
	writer.writerows(new_amenities)
	li2amen_writer.writerows(listing_amenities)

	i=i+1



# 2) check host tables for duplicates

print "Checking host files and table for duplicates. . ."

#get hosts table from the database
cur.execute('SELECT * FROM Host')
h = cur.fetchall()
db_hosts = h
		
boston_hosts = csv.reader(open('data/boston_normalizedCSVs/host.csv','r'))
denver_hosts = csv.reader(open('data/denver_normalizedCSVs/host.csv','r'))
portland_hosts = csv.reader(open('data/portland_normalizedCSVs/host.csv','r'))
hosts_writer = csv.writer(open('data/output/all_hosts_noduplicates.csv','wb'))
hosts = [denver_hosts, portland_hosts]

#write header
hosts_writer.writerow(next(boston_hosts))
	
#get all hosts from Boston
all_hosts = []
for host in boston_hosts:
	all_hosts.append(host)

#add hosts from Denver and Portland, without duplicates	
for reader in hosts:
	next(reader)
	for new_host in reader:
		a = True
		for host in all_hosts:
			if(host[0] == new_host[0]):
				a= False
		if(a==True): all_hosts.append(new_host)
		
#remove hosts that exist in the database		
for host in all_hosts:
	for db_host in db_hosts:
		if(host[0]==str(db_host[0])):
			all_hosts.remove(host)

#write hosts in csv file			
hosts_writer.writerows(all_hosts)

	
# 3) fix zip code values in neighborhoods (in Boston and Portland)

print "Fixing neighborhood files. . ."

readers = [csv.reader(open('data/boston_normalizedCSVs/neighborhood.csv','r'))
		  ,csv.reader(open('data/portland_normalizedCSVs/neighborhood.csv','r'))]
writeFiles = [open('data/output/neighborhoodB_fixed.csv','wb'),open('data/output/neighborhoodP_fixed.csv','wb')]
writers = [csv.writer(writeFiles[0])
		  ,csv.writer(writeFiles[1])]

i=0
for reader in readers:
	writer = writers[i]
	i= i+1
	writer.writerow(next(reader))
	for row in reader:
		if(row[1].isdigit()== False): row[1] = manipulate(row[1])
		writer.writerow(row)
		
writeFiles[0].close()
writeFiles[1].close()	

# 4) remove calculated_host_listings_count column from listing CSVs, and remove invalid characters from zip codes (-/,)

print "Fixing listing files. . ."

listing_readers= [csv.reader(open('data/boston_normalizedCSVs/listing.csv','r'))
				 ,csv.reader(open('data/denver_normalizedCSVs/listing.csv','r'))
				 ,csv.reader(open('data/portland_normalizedCSVs/listing.csv','r'))]
listing_writers= [csv.writer(open('data/output/listingB_fixed.csv','wb'))
				 ,csv.writer(open('data/output/listingD_fixed.csv','wb'))
				 ,csv.writer(open('data/output/listingP_fixed.csv','wb'))]
files = [open('data/output/neighborhoodB_fixed.csv','r'),open('data/denver_normalizedCSVs/neighborhood.csv','r'),open('data/output/neighborhoodP_fixed.csv','r')]
neighborhood_readers = [csv.reader(files[0]),csv.reader(files[1]),csv.reader(files[2])]

		
i = 0
for reader in listing_readers:
	writer = listing_writers[i]
	n_reader = neighborhood_readers[i]
	header = next(reader)
	del header[69]
	writer.writerow(header)
	for row in reader:
		#if the zip code is blank search for the right one in the neighborhoods
		if((row[21]!='') & ((row[25]=='') or (row[25]=='0'))): 
			for n in n_reader:
				if(row[21]==n[0]):
					row[25]=n[1]
					row[22]=n[1]
					break
			files[i].seek(0)
		del row[69]
		if(row[22].isdigit()== False):
			row[22] = manipulate(row[22])
		if(row[25].isdigit()== False):
			row[25] = manipulate(row[25])
		writer.writerow(row)
	i = i+1
		
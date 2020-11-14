import csv

#manipulating Zillow data to create a new schema

files = [open('data/Zip_MedianRentalPrice_with_header/Zip_MedianRentalPrice_1Bedroom.csv','r')
		,open('data/Zip_MedianRentalPrice_with_header/Zip_MedianRentalPrice_2Bedroom.csv','r')
		,open('data/Zip_MedianRentalPrice_with_header/Zip_MedianRentalPrice_3Bedroom.csv','r')
		,open('data/Zip_MedianRentalPrice_with_header/Zip_MedianRentalPrice_4Bedroom.csv','r')
		,open('data/Zip_MedianRentalPrice_with_header/Zip_MedianRentalPrice_5BedroomOrMore.csv','r') ]
		
locations_csv = open('data/output/locations.csv','wb') 
rentalPrice_csv = open('data/output/rental_price.csv','wb')

readers = [csv.reader(files[0]),csv.reader(files[1]),csv.reader(files[2]),csv.reader(files[3]),csv.reader(files[4])]
writers = [csv.writer(locations_csv),csv.writer(rentalPrice_csv)]
locations =  set()
rentalPrice = set()
dates_first_index = []
dates = []

#write headers
writers[0].writerow(('zip_code','city','state','metro','country_name'))
writers[1].writerow(('zip_code','bedrooms','size_rank','date','available','price'))

#find date starting indexes in all 5 csv files
for reader in readers:
	first_row = next(reader)
	i = 0
	while(first_row[i] != '2016-01'):
		i= i+1
	dates_first_index.append(i)

#find the dates from the file
foo = i
for i in range(25):
	dates.append(first_row[foo+i]+"-01")

zip_codes = []
bedrooms = 1
for reader in readers:
	for row in reader:
		locations.add(((row[0]).lstrip("0"),row[1],row[2],row[3],row[4]))
		zip_codes.append(row[0])
		for i in range(len(dates)):
			available = 'false'
			if(row[dates_first_index[bedrooms-1]+i]==''): available = 'true'
			rentalPrice.add((row[0],bedrooms,row[5],dates[i],available,row[dates_first_index[bedrooms-1]+i]))
	bedrooms = bedrooms +1
	
writers[0].writerows(locations)
writers[1].writerows(rentalPrice)
	
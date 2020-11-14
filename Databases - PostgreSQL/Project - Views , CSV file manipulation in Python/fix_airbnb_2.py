import csv

# 5) find zipcodes for summary_listing table from listing table, 
#    also spot some listing_ids that don't belong to an existing listing, to be deleted

print "Fixing zip_codes in summary_listing files. . ."

li_readers = [csv.reader(open('data/output/listingB_fixed.csv','r'))
			 ,csv.reader(open('data/output/listingD_fixed.csv','r'))
			 ,csv.reader(open('data/output/listingP_fixed.csv','r'))]
sum_li_readers = [csv.reader(open('data/boston_normalizedCSVs/summary_listing.csv','r'))
				 ,csv.reader(open('data/denver_normalizedCSVs/summary_listing.csv','r'))
				 ,csv.reader(open('data/portland_normalizedCSVs/summary_listing.csv','r'))]
sum_li_writers = [csv.writer(open('data/output/summary_listingB_fixed.csv','wb'))
				 , csv.writer(open('data/output/summary_listingD_fixed.csv','wb'))
				 ,csv.writer(open('data/output/summary_listingP_fixed.csv','wb'))]

to_be_removed = []
i=0
for reader in sum_li_readers:
	writer = sum_li_writers[i]
	li_reader = li_readers[i]
	listings = []
	next(li_reader)
	#get all listing's ids and zip codes (for faster searching)
	for li in li_reader:
		listings.append((li[0],li[25]))
	writer.writerow(next(reader))
	for sum_li in reader:
		a = False
		name = sum_li[4]
		for li in listings:
			if(sum_li[0]==li[0]):
				a = True
				sum_li[4] = li[1]
				break
		if(a == True):
			writer.writerow(sum_li)
		else:
			to_be_removed.append(sum_li[0])
	i = i+1

	
# 6) removing extra reviews, summary_reviews and calendars from Boston's data

print "Removing extra reviews, summary_reviews and calendars from Boston's data. . ."
file_sumrev = open('data/output/summary_reviewB_fixed.csv','wb')
read = [csv.reader(open('data/boston_normalizedCSVs/review.csv','r'))
	   ,csv.reader(open('data/boston_normalizedCSVs/calendar.csv','r'))
	   ,csv.reader(open('data/boston_normalizedCSVs/summary_review.csv','r'))]
write = [csv.writer(open('data/output/reviewB_fixed.csv','wb'))
		,csv.writer(open('data/output/calendarB_fixed.csv','wb'))
		,csv.writer(file_sumrev)]

i = 0
for reader in read:
	writer = write[i]
	writer.writerow(next(reader))
	for row in reader:
		if(row[0] not in to_be_removed):
			writer.writerow(row)
	i= i+1

file_sumrev.close()


# 7) create Denver's summary_review

print "Creating Denver's summary_review data. . ."

denver_review = csv.reader(open('data/denver_normalizedCSVs/review.csv','r'))
file = open('data/output/summary_review_D.csv','wb')
denver_sumreview = csv.writer(file)

#skip header
next(denver_review)

denver_sumreview.writerow(('listing_id','date'))
summary_reviews = set()
for row in denver_review:
	summary_reviews.add((row[0],row[2]))

denver_sumreview.writerows(summary_reviews)

file.close()


require 'date'

start_date = Date.new(2000,1,1) # get date for the first day of the year 2000
start_month = start_date # copy of the start date that will be modified as iteration occurs - used to denote first day of month
end_month = start_month # copy of the start date that will be modified as iteration occurs - used to denote last day of month
$count = 0 # keeps count of years with at least 1 month with 5 full weekends ('$' sign indicates global variable)

# get user input and convert it to an integer value
print "\n" + "Enter a year after 2000: " 
end_year = gets.to_i

# iterate from year 2000 to the year entered by the user
while start_month.year <= end_year do

	end_month = start_month.next_month - 1 # goes to last day of end_month

	# day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6
	id_Fridays = [5]
	id_Saturdays = [6] 
	id_Sundays = [0]

	result1 = (start_month..end_month).to_a.select {|k1| id_Fridays.include?(k1.wday)} # iterates through each day in end_month and checks for Friday
	result2 = (start_month..end_month).to_a.select {|k2| id_Saturdays.include?(k2.wday)} # iterates through each day in end_month and checks for Saturday
	result3 = (start_month..end_month).to_a.select {|k3| id_Sundays.include?(k3.wday)} # iterates through each day in end_month and checks for Sunday

	# if you find a month with 5 full weekends, then increment the count and go to the first day of the next year since we are looking for years with months without 5 full weekends
	if result1.size == 5 && result2.size == 5 && result3.size == 5 
		$count = $count + 1
		start_month = Date.new(end_month.year + 1, 1, 1)
		next
	end

	# if you managed to get to December of the year and did not find any months with 5 full weekends until then, print out the year as this year does not have any months with 5 full weekends
	if start_month.month == 12
		puts "Year #{start_month.year}"
	end

	# go to the first day of the next month
	start_month = start_month.next_month
end

# Since the count variable represents the total number of years that had at least 1 month with 5 full weekends, we use it to calculate the total number of years that do not have any months with 5 full weekends
$count = (end_year - 2000 + 1) - $count

puts "The result is #$count"
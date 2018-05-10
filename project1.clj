(ns proj1
	(:import java.util.Calendar)
)

(defn project1 []

	; get date for the first day of the year 2000
	(def start_month (Calendar/getInstance))
	(.set start_month 2000,0,1)

	(def counter (atom 0)) ; keeps count of years with at least 1 month with 5 full weekends
	(def Friday_count (atom 0)) ; keeps count of the number of Fridays in a month
	(def Saturday_count (atom 0)) ; keeps count of the number of Saturdays in a month
	(def Sunday_count (atom 0)) ; keeps count of the number of Sundays in a month
	(def year (atom (.get start_month Calendar/YEAR))) ; keeps track of which year we are in during the iterations
	(def month_days (atom 0)) ; stores the total number of days of any particular month
	(def indicator (atom 0)) ; used to indicate that we are in a year that does not have any months with 5 full weekends

	; accept user input and coerce it to an integer value
	(println "Enter a year after 2000: ")
	(def end_year)
	(let[end_year (read)]
		(int end_year)

		; iterate from year 2000 to the year entered by the user
		(while (<= (.get start_month Calendar/YEAR) end_year)
			(do
				(reset! year (.get start_month Calendar/YEAR)) ; updates the year as iterations occur

				; reset the weekend counters after each month
				(reset! Friday_count 0)
				(reset! Saturday_count 0)
				(reset! Sunday_count 0)
				(reset! indicator 0)

				; store the total number of days in the current month as the month may change later on
				(reset! month_days (.getActualMaximum start_month Calendar/DATE))

				; iterate over each day in the month and count the number of Fridays, Saturdays, and Sundays and check to see if you've reached December (update indicator if you have)
				(loop [x (.get start_month Calendar/DAY_OF_MONTH)]
					(when (<= x @month_days)
						
						(if (== (.get start_month Calendar/DAY_OF_WEEK) 6) (swap! Friday_count inc))

						(if (== (.get start_month Calendar/DAY_OF_WEEK) 7) (swap! Saturday_count inc))

						(if (== (.get start_month Calendar/DAY_OF_WEEK) 1) (swap! Sunday_count inc))

						(if (== (.get start_month Calendar/MONTH) 11) (reset! indicator 1))

						(doto start_month (.add Calendar/DATE 1))
						(recur (+ x 1))
					)
				)

				; if you find a month with 5 full weekends, then increment the count and go to the first day of the next year since we are looking for years with months without 5 full weekends
				; if not, then check indicator to see if you reached December and have checked all the months in the year - if you have then print out the year as this year does not have any months with 5 full weekends
				(if (and (== @Friday_count 5) (== @Saturday_count 5) (== @Sunday_count 5)) 
					(do
						(swap! counter inc)
						(swap! year inc)
						(.set start_month @year,0,1)
					)

					(if (== @indicator 1)
						(println "Year" @year)
					)
				)
			)
		)

		; Since the count variable represents the total number of years that had at least 1 month with 5 full weekends, we use it to calculate the total number of years that do not have any months with 5 full weekends
		(reset! counter (- (+ (- end_year 2000) 1) @counter))
		(println "The result is" @counter)
	)

)

(project1)
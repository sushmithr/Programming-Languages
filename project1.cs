using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project1
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime start_month = new DateTime(2000, 1, 1); // initially represents the first day of the year 2000 - modified later on to represent the first day of any month
            DateTime end_month = new DateTime(2000, 1, 1); //initially represents the first day of the year 2000 - modified later on to represent the last day of any month

            int count = 0; // keeps count of years with at least 1 month with 5 full weekends
            int Friday_count; // keeps count of the number of Fridays in a month
            int Saturday_count; // keeps count of the number of Saturdays in a month
            int Sunday_count; // keeps count of the number of Sundays in a month

            // accept user input and check if it can be parsed into an integer value (if not notify user appropriately)
            Console.WriteLine("Enter a year after 2000: ");
            int end_year;
            if (int.TryParse(Console.ReadLine(), out end_year))
            {
                //Console.WriteLine(end_year); 
            }
            else
            {
                Console.WriteLine("Incorrect input. Please try again."); 
            }

            // iterate from year 2000 to the year entered by the user
            while (start_month.Year <= end_year)
            {
                // adds one month and then subtracts one day afterwards from the first day of the month to get the last day of the month
                end_month = start_month.AddDays(0).AddMonths(1).AddDays(-1);

                // reset weekend counters after checking every month
                Friday_count = 0;
                Saturday_count = 0;
                Sunday_count = 0;

                // go through each day of the month and count the number of Fridays, Saturdays, and Sundays
                for (DateTime date = start_month; date.Date <= end_month.Date; date = date.AddDays(1))
                {
                    if (date.DayOfWeek == DayOfWeek.Friday)
                    {
                        Friday_count = Friday_count + 1;
                    }

                    if (date.DayOfWeek == DayOfWeek.Saturday)
                    {
                        Saturday_count = Saturday_count + 1;
                    }

                    if (date.DayOfWeek == DayOfWeek.Sunday)
                    {
                        Sunday_count = Sunday_count + 1;
                    }
                }

                // if you find a month with 5 full weekends, then increment the count and go to the first day of the next year since we are looking for years with months without 5 full weekends
                if (Friday_count == 5 && Saturday_count == 5 && Sunday_count == 5)
                {
                    count = count + 1;
                    DateTime reset_month = new DateTime(end_month.Year + 1, 1, 1);
                    start_month = reset_month;
                    continue;
                }

                // if you managed to get to December of the year and did not find any months with 5 full weekends until then, print out the year as this year does not have any months with 5 full weekends
                if (start_month.Month == 12)
                {
                    Console.WriteLine("Year {0}", start_month.Year);
                }

                // go to the first day of the next month
                start_month = start_month.AddDays(0).AddMonths(1).AddDays(0);
            }

            // Since the count variable represents the total number of years that had at least 1 month with 5 full weekends, we use it to calculate the total number of years that do not have any months with 5 full weekends
            count = (end_year - 2000 + 1) - count;

            Console.WriteLine("The result is {0}", count);

            //Console.ReadKey();
        }
    }
}
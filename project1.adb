with Ada.Text_IO;              use Ada.Text_IO;
with Ada.Calendar.Formatting;  use Ada.Calendar;
with Ada.Integer_Text_IO;

use Ada.Calendar.Formatting;

procedure proj1 is
   start_month : Natural := 1;
   start_day : Natural := 1;
   start_year : Natural := 2000;

   count : Integer := 0; -- keeps count of years with at least 1 month with 5 full weekends
   Friday_count : Natural := 0; -- keeps count of the number of Fridays in a month
   Saturday_count : Natural := 0; -- keeps count of the number of Saturdays in a month
   Sunday_count : Natural := 0; -- keeps count of the number of Sundays in a month

   end_year : Integer; -- stores user input
begin
   -- accept user input
   Ada.Text_IO.Put ("Enter an year after 2000: ");
   Ada.Integer_Text_IO.Get(end_year);
   --Ada.Text_IO.Put_Line (Integer'Image(end_year));

   -- iterate from the year 2000 to the year entered by the user
   for Year in Year_Number range 2000..end_year loop
      -- iterate over each month in the year
      for Month in Month_Number range 1..12 loop
         
         -- reset the weekend counters after each month
         Friday_count := 0;
         Saturday_count := 0;
         Sunday_count := 0;
         
         -- iterate over each day in the month (range adjust automically to match the month you are on) and count the number of Fridays, Saturdays, and Sundays
         for Day in Day_Number range 1..31 loop
            begin
               if Day_Of_Week (Formatting.Time_Of (Year, Month, Day)) = Thursday then
                  Friday_count := Friday_count + 1;
               end if;

               if Day_Of_Week (Formatting.Time_Of (Year, Month, Day)) = Friday then
                  Saturday_count := Saturday_count + 1;
               end if;

               if Day_Of_Week (Formatting.Time_Of (Year, Month, Day)) = Saturday then
                  Sunday_count := Sunday_count + 1;
               end if;
            exception
               when Time_Error =>
                  null;
            end;
         end loop;

         -- if you find a month with 5 full weekends, then increment the count and go to the first day of the next year since we are looking for years with months without 5 full weekends
         if Friday_count = 5 and Saturday_count = 5 and Sunday_count = 5 then
            count := count + 1;
            exit;
         end if;
         
         -- if you managed to get to December of the year and did not find any months with 5 full weekends until then, print out the year as this year does not have any months with 5 full weekends
         if Month = 12 then
            Put_Line ("Year" & Integer'Image (Year));
         end if;

      end loop;

   end loop;
   
   -- Since the count variable represents the total number of years that had at least 1 month with 5 full weekends, we use it to calculate the total number of years that do not have any months with 5 full weekends
   count := (end_year - 2000 + 1) - count;
   Put_Line ("The result is" & Integer'Image (count));
end proj1;
=======================================================================
Text Proccessing with SED and AWK tools
=======================================================================

Description
============

This repository contains a BASH shell script that I implemented to manage a user log file
events (log files) for navigating social networks on the Internet. The file event.dat contains 9500 records and each one contains elements according to
the following wording and formatting:

  **id|lastName|firstName|gender|birthday|joinDate|IP|browserUsed|socialmedia**



The script tools.sh support the following functionallities:
                    
              #. Execution of the command: ::

                     ./tool.sh -f <file>

                 Displays the entire contents of the file, without the comment lines that should
                 have been ignored.
              
              #. Execution of the command: ::

                     ./tool.sh -f <file> -id <id>

                 Displays the first name, last name, and date of birth of the user with the given one
                 id, separated by a single space.


              #. Execution of the command: ::

                     ./tool.sh --firstnames -f <file>

                 Displays all distinct first names (firstname field) contained in the file,
                 in alphabetical order.


              #. Execution of the command: ::

                     ./tool.sh --lastnames -f <file>
                    
                 Displays all distinct first names (lasttname field) contained in the file,
                 in alphabetical order.


              #. Execution of the command: ::

                     ./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
                     
                 Displays only the rows that correspond to users born from
                 date dateA to date dateB. Either can be given, eg, to display all users born on a day or                         later, or born until some day. For each user that meets the criteria, be displayed
                 the line exactly as it was in the file. 




              #. Execution of the command: ::

                     ./tool.sh --socialmedia -f <file>
                     
                 Displays all social media (social media) used by
                 users, in alphabetical order, and next to each and every social network name
                 will display the number of users who used it.




              #. Execution of the command: ::

                     ./tool.sh -f <file> --edit <id> <column> <value>
                     
                 Modifys the file. Specifically, for the user with code <id>, it will replace the
                 column <column> with value <value>. If there is no user with this id, or
                 column is not among the accepted columns 2 through 8 (column 1 corresponding to the same
                 id is not allowed to change), this command will not change anything. Beyond the
                 requested change, nothing else should be changed, i.e. it should
                 the original sorting of records including comments is preserved.





============

Testing the Tool
=============

I now present some examples of execution.


              * Execution of the command: ::

                    ./tool.sh -f event.dat


                .. image:: /Images/1.png

                As you can see the desired functionality is achieved. The whole file as it is gets displayed.
              
              
              * Execution of the command: ::

                     ./tool.sh -f event.dat -id 1099511629352

                .. image:: /Images/2.png

                As you can see the desired functionality is achieved. The first name, last name, and date of birth of the user with the given id is displayed.

              
              * Execution of the command: ::

                     ./tool.sh --firstnames -f event.dat | head

                .. image:: /Images/3.png

                As you can see the desired functionality is achieved. All distinct first names (firstname field) contained in the file got displayed
                in alphabetical order. I just used head to print only the first few.


              * Execution of the command: ::

                     ./tool.sh --lastnames -f event.dat | head

                .. image:: /Images/4.png

                
                As you can see the desired functionality is achieved. All distinct Last names (Lastname field) contained in the file got displayed
                in alphabetical order. I just used head to print only the first few.
  

              * Execution of the command: ::

                     ./tool.sh --born-since 1989-12-03 --born-until 1990-01-09 -f event.dat | head

                .. image:: /Images/5.png


                As you can see the desired functionality is achieved. It prints only the rows that correspond to users born from
                date 1989-12-03 to date 1990-01-09.



              * Execution of the command: ::

                     ./tool.sh --socialmedia -f event.dat

                .. image:: /Images/6.png


                As you can see the desired functionality is achieved. The script 
                displays all social media used by users, in alphabetical order and its corresponding 
                number of users from the file that use it. 



              * Execution of the command: ::

                     ./tool.sh -f event.dat --edit 1099511629352 firstName NUNEZ


                .. image:: /Images/7.png


                As you can see the desired functionality is achieved. The script
                modifys the file for the user with code 1099511629352. It replaces the
                column **firstName** with value **NUNEZ**. 


============

Free software: MIT license
============

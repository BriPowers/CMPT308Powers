Brian Powers
lab 9
4/11/17


1. 
•	people
◦	PID → FIRST_NAME,LAST_NAME,DOB, ADDRESS, Phone #

•	Coach
◦	PID,CID → Years Coaching,total number of teams coaching

•	head Coach
◦	PID,TID,CID → Years Head Coaching, Teams Head Coaching

•	Assisstant Coach
◦	PID,TID,CID → Years Assisstant Coaching, Teams Assisstant Coaching

•	Players
◦	PID,PLNUM,TID → Position,Stats,Age

•	Teams
◦	TID → Team Name, Win/Lose Ratio, Age Group Max ,Age Group Min

3. 
	My Little league database is in third normal form and i can prove it to you.  its in 
	first normal form, by having every singular value of data that pertains to some thing or portion
	of a thing its own in a set of rows and columnms.  Its in second normal form because it is in first 
	normal form and it undertakes functional.  Every table has a primary key or set of primary keys that
	make it able to uniquely identify every team of every age group, each assisstant and head coach and 
	every player on it.   
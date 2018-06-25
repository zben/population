### Introduction
This program takes a data set and offers 3 features:

1. Return States with Populations above 10 Million
2. Return Average City Population by State
3. Return Largest and Smallest Cities by State

### How to run tests
run `ruby data_set_test.rb`

### How to run the program
run `ruby population.rb`

### Design Approach and Data Processing Complexity
* Data processing complexity is O(n) for the entire program and also for each feature.
* We pre-process the data by aggregating on the state population and that of each city in the state by using a nested hash to track the running sums.
* Feature 1 uses the aggregated state population already saved.
* Feature 2 uses the aggregated city population for a given state and performs a division of sum by count.
* Feature 3 loops through each city population for a given state and update the max and min along the way. 
* Since we only care about max and min for feature 3, it is O(n).
* If we want to truly sort for all cities, that would call for a sorting algorithm that needs `O(n*log(n))` runtime.
* We handle invalid input by asking user to enter a valid input again.

### Example output
```
Below are the three features supported by this program.
1. Return States with Populations above 10 Million
2. Return Average City Population by State
3. Return Largest and Smallest Cities by State
Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
1
[{"_id":"NY","pop":17990402},{"_id":"PA","pop":11881643},{"_id":"FL","pop":12686644},{"_id":"OH","pop":10846517},{"_id":"IL","pop":11427576},{"_id":"TX","pop":16984601},{"_id":"CA","pop":29754890}]

Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
2
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
MN
{"_id":"MN","avgCityPop":5372}

Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
3
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
RI
{"state":"RI","biggestCity":{"name":"CRANSTON","pop":176404},"smallestCity":{"name":"CLAYVILLE","pop":45}}

Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
2
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
TEST
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
MN
{"_id":"MN","avgCityPop":5372}

Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
3
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
TEST
Enter a two character state name in upper case like 'CA' and 'FL'. Enter 'quit' to quit.
quit
Which feature do you want to use? Enter the feature number. Enter 'quit' to quit.
quit
```

# Driving History

## Usage

To generate a report and print it to the terminal, run `ruby generate_report.rb example_inputs/problem_statement.txt`.

## Tests

Run all tests with `bin/rpsec`. Test output will include a report of lines and percentage of lines covered. To view the full report open the `coverage/index.html` after running the full test suite.

## Approach

I tackled the problem at a high level by,
1. Reading the input file split by each line
2. Composing an array of Drivers with their associated Trips
3. Building the output report by sorting then iterating through the array of Drivers & their Trips

Upon reading the problem and seeing the example input, my first instinct was to build a hash with the driver as the key and the trip data as an array of hashes representing each trip. That would be a good approach during a timed algorithm interview however, given that I'm able to use any data structure that I'd like, it made more sense to model the objects. The data models used are Driver and Trip with a one-to-many relationship.

Some of the considerations I took into account were 1) deduping a driver if the input tries to register them twice, 2) trip commands for drivers that are not registered, and 3) invalide commands (not “Trip” or “Driver”). All of these cases are handled and tested.

From the problem statement and example data, I assume that 1) trips all happen within a 24 hour window, 2) data is clean, ie. always properly formatted and space delimited, and 3) data is valid, ie. no negative miles or invalid timestamps. These cases are not handled or tested.

After building the basic data models, I decided not to write any logic until I had some sample and test data. I added Faker to generate some driver names and added a script to build sample data for a large amount of drivers and trips. This data can be generated via `ruby generate_sample_data.rb`.

An interesting piece of implementation worth noting is the TripStats class. The methods within it could belong in the Driver as they all relate to the driver’s trips. By abstracting the TripStats class and allowing it to take a list of trips, it becomes reusable for any list of trips and keeps the responsibility of computing the stats out of the Driver. TripStats also makes sure to only iterate the trips once regardless of what method is called by using memoization. The filtering out of trips that don’t meet the speed requirements is controlled by `FAST_LIMIT`, and `SLOW_LIMIT` constants that could be further abstracted into arguments (perhaps with default values).

## Improvements

If I had more time, I would have unit tested every model, service, and util, as well as the command line ruby script that calls the main report generation service. That said, I was able to exercise every line of code and achieve 100% test coverage from the pseudo-integration spec for `GenerateDriversReport`.

Given any further requirements, or the ability to ask questions about future use cases, I would have abstracted further. For example, the way that a report is built in `GenerateDriversReport` could change and it may make sense to pull it out into a separate service as I did with `CommandParser` to handle how the report is parsed. To respect the Dependency Inversion Principle, these collaborators can be passed in as arguments (perhaps with a default parser/report builder) so that the report generator isn’t concretely tied to how it’s parsing and building the report.

I could have used Time when doing the duration computation but that would have been overkill for the task at hand. In the future, if more were to be done with the start and end times, it would make sense to have them as Ruby Time objects to have all the surrounding Time methods.

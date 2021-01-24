# Driving History

## Thought Process
Upon reading the problem and seeing the example input, my first instinct is to build a hash with the driver as the key and the trip data as an array of hashes representing each trip. That would be a good approach during a timed algorithm interview however, given that I'm able to use any data structure that I'd like, it made more sense to model the object. The obvious data models are Driver and Trip with a one-to-many relationship.

Other top of mind considerations are 1) deduping a driver if the input tries to register them twice, and 2) trip commands for drivers that are not registered. From the problem statement and example data, I assume that 1) trips all happen within a 24 hour window, 2) data is clean, ie. always properly formatted and space delimited, and 3) data is valid, ie. no negative miles or invalid timestamps.

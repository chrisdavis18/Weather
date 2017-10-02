#  Weather
## Comments
### The public API is using HTTP, which could cause some issues because of Apple's security standards.  I had to add the AllowsArbitraryLoads key in order to bypass this
### The city list file from OpenWeatherMap is very extensive, an improvement could be to write a script to remove all non-US cities, add the file to the project, and parse it on loading.  This way, I could use it for searching to guarantee the user selects a valid city
### With more time, I would have added a search display controller, which displays prior searches (storing them when a user searches).  Also, more tests need to be added to mock API calls and test functionality (Setting up the cells for the table view)
### I added a second view controller, that shows the 5 day forecasts (every 3 hours) for the selected city.
### This challenge, and the previous one (Music Search) can be found at github.com/chrisdavis18, I created a workaround for the MusicSearch Challenge that fixed the issue with the API Call not returning valid JSON.


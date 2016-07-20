# earthquakes
Earthquakes portfolio app

Objective:
1. Create a web page that takes as input a city/location name.
2. This page should call the GeoNames Recent Earthquake WebService (http://
www.geonames.org/export/JSON-webservices.html#earthquakesJSON), with a bounding box dictated by the city entered.
3. Plot the results on a Google Map (http://code.google.com/apis/maps/). Each marker on this map should display details
of the earthquake plotted.


Source Code Components:

Earthquakes.vfp – a Visualforce page that accepts user input of a location to be used as the center point for 
the earthquakes search. The page uses JavaScript to call a Google Maps geocode RESTful web service to get the 
location‘s latitude and longitude then using Visualforce remoting passes that information to the page controller 
to get a list of earthquakes. Once the results are back from the controller the page displays the earthquakes as 
pins on a world map and attaches information popups (just click the pin) with the details of the selected earthquake. 
Note: use of Visualforce remoting saves the overhead of submitting the whole page. Instead it just makes the remote 
call using only the necessary data and only gets back the results.

EarthquakeController.apxc – Server side Apex controller used for the Visualforce remoting call. The controller makes
a RESTful web service call to geonames.org to obtain the list of earthquakes. It then de-serializes the JSON and sends
the results back to the Visualforce page as a list of earthquake objects.

This project was part of a coding assignment I did to learn how to use the Google Maps APIs. It is now part of my portfolio.


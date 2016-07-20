global with sharing class EarthquakeController {

    public String location { get; set; }

    global class EarthQuake {
        public String eqid;
        public decimal magnitude;
        public decimal lng;
        public String src;
        public String datetime_x;   // Apex doesn't like variables named datetime
        public decimal depth;       // we will adjust the JSON to reflect the name change
        public decimal lat;
    }

    public class QuakeWrapper {
        List<Earthquake> earthquakes;
    }
    // Changes made on 7/7 locally in Eclipse 
    @RemoteAction
    global static List<Earthquake> findAll(String lat, String lon) {
        String url;
        System.debug('In the remote method for the VF page');
        System.debug('lat = ' + lat);
        System.debug('lon = ' + lon);
        System.debug('Build bounding box');

        // Build the bounding box
        Decimal north = Decimal.valueof(lat) + 16;
        Decimal south = Decimal.valueof(lat) - 16;
        Decimal east = Decimal.valueof(lon) + 16;
        Decimal west = Decimal.valueof(lon) - 16;

        System.debug('North:' + north);
        System.debug('South:' + south);
        System.debug('East:' + east);
        System.debug('West:' + west);


        // Build the url
        url = 'http://api.geonames.org/earthquakesJSON?north=' + north + '&south=' + south;
        url = url + '&east=' + east + '&west=' + west + '&username=marshallharrison';
        System.debug(url);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod ('GET');

        HttpResponse response = http.send(request);
        QuakeWrapper wrapper;
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            // Need to change all occurences of "datetime" in the JSON to "datetime_x"
            // before actually deserializing it.
            wrapper = (QuakeWrapper) JSON.deserialize(response.getBody().replace('"datetime"', '"datetime_x"'), QuakeWrapper.class);

            System.debug(wrapper);

        } else {
            System.debug('Could not get earthquakes');
            System.debug(response.getStatus());
        }
        return wrapper.earthquakes;
    }


}
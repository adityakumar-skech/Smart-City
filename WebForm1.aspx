<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="MYCITYV2.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Circles</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
</head>


<body>
    <form id="form1" runat="server">
    <div>
    <div id="leftPanel" style="top:14%;left:0.76%;height:80%;width:20%;position:absolute;background-color:red;z-index:10">
    <div class="container">
    </div>
    </div>
    <div id="map"></div>
    
    </div>
    </form>
    <script>
     var defLat, defLon;
        var mar;
        var locations;
        function setcookie(Long, Latt) {

            var d = new Date();
            d.setTime(d.getTime() + (24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = "coords=" + Long+","+Latt + ";" + expires + ";path=/";
            console.log("cookie set");
         function getCookie() {
            var name = "coords=";

            var decodedCookie = decodeURIComponent(document.cookie);
            console.log(ca);
            var ca = decodedCookie.split(';');
            var inca = ca[0].split('=');
            var lonlat = inca[1].split(',');
            defLon = lonlat[0];
            defLat = lonlat[1];
        }

        function checkCook() {

            if (decodeURIComponent(document.cookie).indexOf("coord") > -1) {
                return true;
            }
            else {
                return false;
            }
        }

        function getLoc() {
            $.ajax({
                type: "POST",
                url: "smartlocator.aspx/getMarkers",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    mar = response.d;
                    //alert(mar);
                    //----------------------------------------------------

                    locations = eval("[" + mar + "]");

                    if (checkCook() == false) {
                        defLat = 19.186475;
                        defLon = 72.9753068;
                    }
                    else {
                        getCookie();
                    }

                    var map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 20,
                        center: new google.maps.LatLng(defLat, defLon),
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    });

                    google.maps.event.addListener(map, "click", function (e) {
                        //lat and lng is available in e object
                        var latLng = e.latLng;
                        console.log(latLng.lat() + " " + latLng.lng());
                        setcookie(latLng.lng(), latLng.lat());
                    });

                    var infowindow = new google.maps.InfoWindow();

                    var marker, i;

                    for (i = 0; i < locations.length; i++) {
                    marker = new google.maps.Marker({
                        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                        map: map
                    });

                    google.maps.event.addListener(marker, 'click', (function (marker, i) {
                        return function () {
                            infowindow.setContent(locations[i][0] + "<BR>" + locations[i][4]);
                            infowindow.open(map, marker);
                        }
                    })(marker, i));
                    }

                    //----------------------------------------------------
                    console.log("6")
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        


        function setLocation() {
            locations = "[" + mar + "]";
            //alert(locations);
            console.log("7")
        }

        function initMap() {

            console.log("1")
            
            getLoc();

            console.log("2")

//            if (checkCook() == false) {
//                defLat = 19.186475;
//                defLon = 72.9753068;
//            }
//            else {
//                getCookie();
//            }

            console.log("3")

//            console.log(defLat);
//            var map = new google.maps.Map(document.getElementById('map'), {
//                zoom: 20,
//                center: new google.maps.LatLng(defLat, defLon),
//                mapTypeId: google.maps.MapTypeId.ROADMAP
//            });


            console.log("4")

//            google.maps.event.addListener(map, "click", function (e) {
//                //lat and lng is available in e object
//                var latLng = e.latLng;
//                console.log(latLng.lat() + " " + latLng.lng());
//                setcookie(latLng.lng(), latLng.lat());
//            });

//            var infowindow = new google.maps.InfoWindow();

            console.log("5")

//            var marker, i;

//            for (i = 0; i < locations.length; i++) {
//                marker = new google.maps.Marker({
//                    position: new google.maps.LatLng(locations[i][1], locations[i][2]),
//                    map: map
//                });

//                google.maps.event.addListener(marker, 'click', (function (marker, i) {
//                    return function () {
//                        infowindow.setContent(locations[i][0] + "<BR>" + locations[i][4]);
//                        infowindow.open(map, marker);
//                    }
//                })(marker, i));
//            }
        }
      
        // This example creates circles on the map, representing populations in North
        // America.

        // First, create an object containing LatLng and population for each city.
        var citymap = {
            chicago: {
                center: { lat: 41.878, lng: -87.629 },
                population: 2714856
            },
            newyork: {
                center: { lat: 40.714, lng: -74.005 },
                population: 8405837
            },
            losangeles: {
                center: { lat: 34.052, lng: -118.243 },
                population: 3857799
            },
            vancouver: {
                center: { lat: 49.25, lng: -123.1 },
                population: 603502
            }
        };

        function initMap() {
            // Create the map.
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 4,
                center: { lat: 37.090, lng: -95.712 },
                mapTypeId: 'terrain'
            });

            // Construct the circle for each value in citymap.
            // Note: We scale the area of the circle based on the population.
            for (var city in citymap) {
                // Add the circle for this city to the map.
                var cityCircle = new google.maps.Circle({
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#FF0000',
                    fillOpacity: 0.35,
                    map: map,
                    center: citymap[city].center,
                    radius: Math.sqrt(citymap[city].population) * 100
                });
            }
        }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDjGqEZsESF4zVW5kdWmXrnEwUbzgb1LV4&callback=initMap">
    </script>
</body>
</html>

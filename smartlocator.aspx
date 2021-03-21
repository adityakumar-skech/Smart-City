<%@ Page Language="C#" AutoEventWireup="true" CodeFile="smartlocator.aspx.cs" Inherits="smartlocator" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
<div class="container-fluid">
    <div class="row"><div class="col-lg-12">&nbsp;</div></div>
    <div class="row">
    <div class="col-xs-2">
    <form id="form1" runat="server">    
    <div id="leftPanel" >
    <div class="panel panel-primary">
      <div class="panel-heading">SEARCH LOCATION</div>
      <div class="panel-body">
      <asp:DropDownList ID="DropDownList1"  CssClass="form-control" runat="server" 
            DataSourceID="SqlDataSource1" DataTextField="catname" DataValueField="catid">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:smartcityDBConnectionString %>" 
            SelectCommand="SELECT * FROM [tbl_category]"></asp:SqlDataSource>        
        <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server">
        </asp:DropDownList>
        <input type="button" class="form-control btn-primary" value="Search" onclick="initMap()" />
    
      </div>
    </div>
    </div>
    </form>
        </div>
        <div class="col-xs-7">
            <div id="map" style="height:600px"></div>
        </div>
        <div class="col-xs-3">
     <div style="height:600px;overflow-y: scroll;" class="panel panel-success">
      <div class="panel-heading">LOCATION INFO</div>
      <div class="panel-body" id="rightside">
      </div>
    </div>
        </div>
    </div>
</div>
    
    
    
    <script>
        var defLat, defLon;
        var mar;
        var locations;
        var gmarkers = [];
        function setcookie(Long, Latt) {

            var d = new Date();
            d.setTime(d.getTime() + (24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = "coords=" + Long+","+Latt + ";" + expires + ";path=/";
            console.log("cookie set");
        }

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
            var selval = $('#DropDownList1').val();
            $.ajax({
                type: "POST",
                url: "smartlocator.aspx/getMarkers",
                data: JSON.stringify({ catid: "'" + selval + "'" }),
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
                        zoom: parseInt($('#DropDownList2').val()),
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
                    $("#rightside").html("");
                    
                    for (i = 0; i < locations.length; i++) 
                    {
                        
                        marker = new google.maps.Marker({
                            position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                            map: map
                        });

                        google.maps.event.addListener(marker, 'click', (function (marker, i) {
                            return function () {
                                infowindow.setContent("<b>" + locations[i][0] + "</b><BR>" + locations[i][4]);
                                infowindow.open(map, marker);
                            }
                        })(marker, i));
                        gmarkers.push(marker)
                        $("#rightside").html($("#rightside").html() + "<div class='well' onclick='panning(" + locations[i][1] + "," + locations[i][2] + ","+ (gmarkers.length - 1) +")'>" + locations[i][0] + "</div>");
                    }

                    //----------------------------------------------------
                    console.log("6");
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }


        function panning(lat, lon, marind) {
            setcookie(lon, lat);
//            defLat = lat;
//            defLon = lon;
//            initMap();
            google.maps.event.trigger(gmarkers[marind], "click");
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

            if (checkCook() == false) {
                defLat = 19.186475;
                defLon = 72.9753068;
            }
            else {
                getCookie();
            }

            console.log("3")

            console.log(defLat);
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 20,
                center: new google.maps.LatLng(defLat, defLon),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });


            console.log("4")

            google.maps.event.addListener(map, "click", function (e) {
                //lat and lng is available in e object
                var latLng = e.latLng;
                console.log(latLng.lat() + " " + latLng.lng());
                setcookie(latLng.lng(), latLng.lat());
            });

            var infowindow = new google.maps.InfoWindow();

            console.log("5")

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
        }
        
    </script>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSqAl9nrG-dhm1ckG7wnjBaRUMNUFYD_g&callback=initMap" async defer></script>
    
</body>
</html>

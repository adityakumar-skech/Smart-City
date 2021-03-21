<%@ Page Language="C#" AutoEventWireup="true" CodeFile="map.aspx.cs" Inherits="map" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<style type="text/css">
    #map
    {
        height:400px;
        width:100%;
        background-color:grey;
    }
</style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
     <h2>MY MAP</h2>
  <div id="map"></div>
  <script>
      function initmap()
     {


           var options=
           {  
           zoom:8,
           center:{lat:19.2183 ,lng:72.9781 }
           }

            var map = new google.maps.Map(document.getElementById('map'),options);
            var marker = new google.maps.Marker({
            position: { lat: 19.2183, lng: 72.9781 },
            map: map
            });

                console.log("aa");

                google.maps.event.addListener(map, "click", function (e) {
                //lat and lng is available in e object
                var latLng = e.latLng;
                console.log(latLng.lat() + " " + latLng.lng());
                //$('#ctl00_ContentPlaceHolder1_TextBox7').val(latLng.lat());
                //$('#ctl00_ContentPlaceHolder1_TextBox8').val(latLng.lng());
                });
            
            
            
       }
   </script>
  <script async defer 
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdYNNFbVHx-h5HV7fBEy6nqdJjw8WN-5o&callback=initMap">
</script>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"><style type="text/css">
                         #map{
                     height : 500px;
                     width : 100%;
                         }
                     </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    <h3>My Google Maps Demo</h3>
    <div id="map"></div>
    <script type="text/javascript">
        function initMap() {
            var options = {
                zoom: 8,
                center: { lat: 19.0760, lng: 72.8777 }
            }
              var map = new google.maps.Map(document.getElementById('map'),options);
            var marker = new google.maps.Marker({
                position: { lat: 19.2183, lng: 72.9781 },
                map: map
            });
        }
    </script>
    <script async defer type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdYNNFbVHx-h5HV7fBEy6nqdJjw8WN-5o&callback=initMap">
    </script>
</body>
</html>

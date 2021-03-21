<%@ Page Title="" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="AddSchools.aspx.cs" Inherits="AddSchools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSqAl9nrG-dhm1ckG7wnjBaRUMNUFYD_g" async defer></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
<div class="col-md-4">
<table class="table">
    <tr><td>SCHOOL NAME</td><td><asp:TextBox CssClass="form-control" ID="TextBox1" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL DETAILS</td><td><asp:TextBox CssClass="form-control" ID="TextBox2" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL WEBSITE</td><td><asp:TextBox CssClass="form-control" ID="TextBox3" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL PHONE NO</td><td><asp:TextBox CssClass="form-control" ID="TextBox4" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL MOBILE NO</td><td><asp:TextBox CssClass="form-control" ID="TextBox5" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL EMAIL</td><td><asp:TextBox CssClass="form-control" ID="TextBox6" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL laTT</td><td><asp:TextBox CssClass="form-control" ID="TextBox7" runat="server"></asp:TextBox></td></tr>
    <tr><td>SCHOOL LOnG</td><td><asp:TextBox CssClass="form-control" ID="TextBox8" runat="server"></asp:TextBox></td></tr>
    <tr><td colspan="2">
        <asp:Button ID="Button1" CssClass="form-control btn-primary" runat="server" 
            Text="ADD SCHOOL" onclick="Button1_Click" /></td></tr>
    </table>
</div>
<div class="col-md-8">
    <div id="map_canvas" style="width: 100%; height: 500px">
    </div>
<div></div>
</div>
    
    
    

     <script type="text/javascript">
         $(document).ready(function () {
             console.log("s1");
             var latlng = new google.maps.LatLng(19.186475, 72.9753068);
             console.log("s2");
             var myOptions = {
                 zoom: 20,
                 center: latlng,
                 mapTypeId: google.maps.MapTypeId.ROADMAP
             };
             console.log("s3");
             var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
             console.log("s4");

             google.maps.event.addListener(map, "click", function (e) {
                 //lat and lng is available in e object
                 var latLng = e.latLng;
                 console.log(latLng.lat() + " " + latLng.lng());
                 $('#ctl00_ContentPlaceHolder1_TextBox7').val(latLng.lat());
                 $('#ctl00_ContentPlaceHolder1_TextBox8').val(latLng.lng());
             });
         }); 
    </script>
</asp:Content>


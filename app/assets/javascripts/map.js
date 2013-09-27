var map;
function initialize() {
    var myLatlng = new google.maps.LatLng(<?=$decimalValueLon?>,<?=$decimalValueLat?>);
    var myOptions = {
    zoom: 17,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.SATELLITE
  };


  map = new google.maps.Map(document.getElementById('map_canvas'),
      myOptions);

  // marker STARTS
  var marker = new google.maps.Marker({
  position: myLatlng,
  title:"Click to view info!"
});
  marker.setMap(map);
  // marker ENDS

  // info-window STARTS
  var infowindow = new google.maps.InfoWindow({ content: "<div class='map_bg_logo'><span style='color:#1270a2;'><b><?=$row->bridge_name?></b> (<?=$row->bridge_no?>)</span><div style='border-top:1px dotted #ccc; height:1px;  margin:5px 0;'></div><span style='color:#555;font-size:11px;'><b>Length: </b><?=$row->bridge_length?> meters</span></div>" });
  google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
  });
  // info-window ENDS
}

google.maps.event.addDomListener(window, 'load', initialize);



//-------------------------TIP------------------------------
// You can add a click-handler like you have a load handler:
//
// google.maps.event.addListener(map, "click", function (e) {
//
//     //lat and lng is available in e object
//     var latlng = e.latlng;
//
// });
//
//
// http://stackoverflow.com/questions/9247006/get-latitude-and-longitude-on-click-event-from-google-map
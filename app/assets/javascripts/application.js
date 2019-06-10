// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// = require rails-ujs
// = require activestorage
// = require_tree .
    
function initMap(lat, lng) {
    var myCoords = new google.maps.LatLng(lat, lng);
    var mapOptions = {
    center: myCoords,
    zoom: 14
    };
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker = new google.maps.Marker({
        position: myCoords,
        map: map
    });
}

// ar handler = Gmaps.build('Google');
// handler.buildMap({ internal: {id: 'multi_markers'}}, function(){
//   var markers = handler.addMarkers([
//     { lat: 43, lng: 3.5},
//     { lat: 45, lng: 4},
//     { lat: 47, lng: 3.5},
//     { lat: 49, lng: 4},
//     { lat: 51, lng: 3.5}
//   ]);
//   handler.bounds.extendWith(markers);
//   handler.fitMapToBounds();
// });
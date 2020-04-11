var map;
var infowindow;

function get Location() {
  // 現在地の取得
  navigator.geolocation.getCurrentPosition(
    function (position) {
      // 現在地の緯度経度
      var latitude = position.coords.latitude;
      var longitude = position.coords.longitude;
      alert('緯度：' + latitude + ' / 経度：' + longitude);
      var latlng = new google.maps.LatLng(latitude, longitude);
      var mapOptions = {
        zoom: 11,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: latlng,
        mapTypeControl: false,
        fullscreenControl: false,
        streetViewControl: false,
        zoomControl: true,
      };
      map = new google.maps.Map(getElementById('map', mapOptions)
      );

      // 現在地を中心にマップに円を描く
      var circleOptions = {
        map: map,
        center: new google.maps.LatLng(latitude, longitude),
        radius: 1000,
        strokeColor: "#009933",
        strokeOpacity: 1,
        strokeWeight: 1,
        fillColor: "#00ffcc",
        fillOpacity: 0.35
      };
      circle = new google.maps.Circle(circleOptions);

      // 現在地から１キロいないの神社・寺院を検索
      infowindow = new google.maps.InfoWindow();
      var service = new google.maps.places.PlacesService(map);
      service.nearbySearch({
        location: latlng,
        radius: 1000,
        type: ['place_of_worship']
      }, callback);
    }, function (error) {
      // 失敗時の処理
      alert('エラー：' + error);
    });
}

// 地図上にマーカーをプロット
function callback(results, status) {
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);
    }
  }
}
// 地図上のマーカーをクリックした際の動作
function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });
  // 吹き出しの中身
  google.maps.event.addListener(marker, 'click', function () {
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + '評価： ' + place.rating + '</div>');
    infowindow.open(map, this);
  });
}



function initialize() {
  var mapOptions = {
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    center: center,
    mapTypeControl: false,
    fullscreenControl: false,
    streetViewControl: false,
    zoomControl: true,
  };

  var initPos = new google.maps.LatLng(34.45501, 136.725793);

  var mapDiv = document.getElementById("map_canvas");
  var map = new google.maps.MAP(mapDiv, mapOptions);
  var request = {
    location: initPos,
    radius: 1000,
    types: ['place_of_worship']
  };
  var servise = new google.maps.places.PlacesService(map);
  service.search(request, Result_Places);
}

function Result_Places(results, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      var place = results[i];
      createMarker({
        text: place.name,
        position: place.geometry.location
      });
    }
  }
}


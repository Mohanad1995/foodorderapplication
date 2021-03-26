import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMaps extends ChangeNotifier{
  GeoPoint geoPoint;
  GeoPoint get getGeoPoint=>geoPoint;
  String finalAdress = 'Searching address ...';
  Position position;
  Position get getPositon =>position;
  String get getFinalAddress=>finalAdress;
  GoogleMapController googleMapController;
  Map<MarkerId,Marker> markers=<MarkerId,Marker>{};
  String countryName,mainAddress='Mock Address';
  String get getCountryName=>countryName;
  String get getMainAddress=>mainAddress;
  Future getCurrentLocation()async{
  var positionData = await GeolocatorPlatform.instance.getCurrentPosition();
  final cords = geoCo.Coordinates(positionData.latitude,positionData.longitude);
  var address= await geoCo.Geocoder.local.findAddressesFromCoordinates(cords);
  String mainAddress = address.first.addressLine;
  print(mainAddress);
  finalAdress = mainAddress;
  print('final:$finalAdress');
  notifyListeners();
}
  getMarkers(double lat,double lng){
    MarkerId markerId=MarkerId(lat.toString()+lng.toString());
    Marker marker=Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(title:getMainAddress,snippet: 'Country name'),
    );
    markers[markerId]=marker;
  }
   featchMaps(){
    return GoogleMap(
      myLocationButtonEnabled: true,
      mapToolbarEnabled: true,
      onTap: (loc) async{
        final cards=geoCo.Coordinates(loc.latitude,loc.longitude);
        var address= await geoCo.Geocoder.local.findAddressesFromCoordinates(cards);
        countryName=address.first.countryName;
        mainAddress=address.first.addressLine;
        geoPoint =GeoPoint(loc.latitude,loc.longitude);
        notifyListeners();
        markers == null ? getMarkers(loc.latitude,loc.longitude):markers.clear();
      },
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController mapController){
        googleMapController=mapController;
        notifyListeners();
      },
      initialCameraPosition: CameraPosition(target: LatLng(31.5,34.5),zoom: 2,),
      mapType: MapType.hybrid,

    );
  }
}
import 'package:coval/loading/loading.dart';
import 'package:coval/services/businesses_data_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();

  MapPage({Key key}) : super(key: key);
}

class _MapPageState extends State<MapPage> {
  final BusinessesDataService businessesDataService = BusinessesDataService();

  GoogleMapController mapController;
  Position position;
  Set<Marker> markers;

  @override
  void initState() {
    getCurrentLocation();
    getMarkers();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void getMarkers() async {
    Set<Marker> markersSet =
        await businessesDataService.getBusinesses().then((businesses) {
      return businesses.map((business) {
        return Marker(
            position: business.coordinates,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            markerId: MarkerId(business.uid),
            infoWindow: InfoWindow(
              title: business.name,
            ));
      }).toSet();
    });
    setState(() {
      markers = markersSet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return position == null ? Loading(): GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 12.0),
            onMapCreated: _onMapCreated,
          );
  }
}

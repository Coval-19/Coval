import 'package:coval/loading/loading.dart';
import 'package:coval/models/business_data.dart';
import 'package:coval/models/user_data.dart';
import 'package:coval/services/businesses_data_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'businesses/business_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final BusinessesDataService businessesDataService = BusinessesDataService();

  GoogleMapController mapController;
  Position position;
  UserData userData;

  @override
  void initState() {
    getCurrentLocation();
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

  Marker getMarker(BusinessData businessData) {
    return Marker(
        position: businessData.coordinates,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        markerId: MarkerId(businessData.uid),
        infoWindow: InfoWindow(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BusinessPage(businessData: businessData, userData: userData,)));
          },
          title: businessData.name,
          snippet: businessData.address,
        ));
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context) ?? null;
    final businesses = Provider.of<List<BusinessData>>(context);
    Set<Marker> markers =
        businesses.length > 0 ? businesses.map(getMarker).toSet() : Set();
    return position == null
        ? Loading()
        : GoogleMap(
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

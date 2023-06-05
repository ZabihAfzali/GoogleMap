import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(34.192683, 73.241139),
        infoWindow: InfoWindow(title: "Abbottabad")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(33.738045, 73.084488),
        infoWindow: InfoWindow(title: "Islamabad"))
  ];

  Completer<GoogleMapController> _completer = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.192683, 73.241139),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          mapToolbarEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled,color: Colors.blue),
        onPressed: () async {
          GoogleMapController controller = await _completer.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(33.738045, 73.084488),
            zoom: 14,
          )));
          setState(() {

          });
        },
      ),
    );
  }
}

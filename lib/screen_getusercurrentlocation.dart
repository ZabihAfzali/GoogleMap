import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {



  
  final List<Marker> _list = <Marker>[
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(33.738045, 73.084488),
        infoWindow: InfoWindow(title: "Islamabad"))
  ];

  Completer<GoogleMapController> _completer = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.192683, 73.241139),
    zoom: 14,
  );

  Future<Position> getUserLocation() async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("Error details: ${error.toString()}");

    });
    return await Geolocator.getCurrentPosition();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }









  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_list),
        onMapCreated: (GoogleMapController controller){
          _completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        getUserLocation().then((value) async{
          print("My current location");
          print(value.latitude.toString()+" "+value.longitude.toString());
          _list.add(
              Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: "My current location",
                )
              )
          );
          CameraPosition cameraPosition=CameraPosition(target:
          LatLng(value.latitude, value.longitude),
            zoom: 14,
          );
          final GoogleMapController controller=await _completer.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {

          });
        });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui'as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({Key? key}) : super(key: key);

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {


  Completer<GoogleMapController> _completer = Completer();

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAssetes(String path, int width) async{
    ByteData data=await rootBundle.load(path);
    ui.Codec codec=await ui.instantiateImageCodec(data.buffer.asUint8List(),targetHeight:width);
    ui.FrameInfo fi=await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();




  }

  final List<Marker> _marker = <Marker>[
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(33.738045, 73.084488),
        infoWindow: InfoWindow(title: "Islamabad"))
  ];

  List<String> images=[ "images/car.png","images/car.png",
      "images/hotel.png",
      "images/petrol.png",
      "images/petrol-pump.png"];

  final List<LatLng> latLong=<LatLng>[
    LatLng(33.6446,33.6956),
    LatLng(33.7155, 73.1305),
    LatLng(33.6377, 73.0301),
    LatLng(33.7383, 73.0565),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.192683, 33241139),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _completer.complete(controller);
          },
        ),
      ),
    );
  }

  void loadData() async{
    for(int i=0;i<images.length;i++){


      final Uint8List markerIcon=await getBytesFromAssetes(images[i], 100);
      _marker.add(
          Marker(
              markerId: MarkerId("${i.toString()}"),
              icon: BitmapDescriptor.fromBytes(markerIcon),
              position: latLong[i],
              infoWindow: InfoWindow(title: "This is title marker ${i.toString()}"))
      );
    }
    setState(() {

    });
  }
}

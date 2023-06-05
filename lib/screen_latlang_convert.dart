
import 'package:geocoding/geocoding.dart';


import 'package:flutter/material.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLangToAddress> createState() => _ConvertLatLangToAddressState();
}

String stAddress="";

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
            centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{

              List<Location> location = await locationFromAddress("52.2165157, 6.9437819");
              List<Placemark> placemarks = await placemarkFromCoordinates(33.9391, 67.7100);
              final query = "1600 Amphiteatre Parkway, Mountain View";

              setState(() {
                stAddress=location.last.longitude.toString()+location.last.latitude.toString();
                placemarks.reversed.last.toString();

                print("Address generated: $stAddress");
                print("Address country: $placemarks");
              });

            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text("Center"),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}

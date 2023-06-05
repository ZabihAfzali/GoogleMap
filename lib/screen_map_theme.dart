import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapTheme extends StatefulWidget {
  const GoogleMapTheme({Key? key}) : super(key: key);

  @override
  State<GoogleMapTheme> createState() => _GoogleMapThemeState();
}

class _GoogleMapThemeState extends State<GoogleMapTheme> {
  String mapTheme = "";
  Completer<GoogleMapController> _completer = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.192683, 73.241139),
    zoom: 14,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/maptheme/silver_theme.json")
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map Themes"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(onTap: () {
                      _completer.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/silver_theme.json").then((string){
                          value.setMapStyle(string);
                        });
                      });
                    }, child: Text("Silver")),
                    PopupMenuItem(onTap: () {
                      _completer.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/retro_theme.json").then((string){
                          value.setMapStyle(string);
                        });
                      });
                    }, child: Text("Retro")),
                    PopupMenuItem(onTap: () {_completer.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/maptheme/dark_theme.json").then((string){
                        value.setMapStyle(string);
                      });
                    });
                      }, child: Text("Dark")),
                    PopupMenuItem(onTap: () {
                      _completer.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/night_theme.json").then((string){
                          value.setMapStyle(string);
                        });
                      });
                    }, child: Text("Night")),
                  ])
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(mapTheme);
            _completer.complete(controller);
          },
        ),
      ),
    );
  }
}

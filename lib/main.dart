import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemappractice/screen_customemarkers.dart';
import 'package:googlemappractice/screen_getusercurrentlocation.dart';
import 'package:googlemappractice/screen_google_places_api.dart';
import 'package:googlemappractice/screen_home.dart';
import 'package:geocoding/geocoding.dart';
import 'package:googlemappractice/screen_latlang_convert.dart';
import 'package:googlemappractice/screen_map_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GoogleMapTheme(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
 // This trailing comma makes auto-formatting nicer for build methods.
    );

}

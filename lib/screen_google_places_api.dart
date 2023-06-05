import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {

  TextEditingController etController=TextEditingController();
  var uuid=Uuid();
  String _sessionToken="1234";
  List<dynamic> placesList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    etController.addListener(() {
      onChange();
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Google search api"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            TextFormField(
              controller: etController,
              decoration: InputDecoration(
                hintText: "Search places with name"
              ),
            ),
            Expanded(
                child: ListView.builder(itemCount: placesList.length,itemBuilder: (context,index){
                  return ListTile(
                    onTap: ()async{
                      List<Location> location= await locationFromAddress(placesList[index]['description']);

                      print("latitude: ${location.last.latitude}");
                      print("longitude: ${location.last.longitude}");


                    },
                    title: Text(placesList[index]["description"]),
                  );
                })
            )
          ],
        ),
      ),
    );
  }

  void onChange() {
    if(_sessionToken==null){
      setState(() {
        _sessionToken=uuid.v4();
      });
    }
    getSuggession(etController.text);
  }

  void getSuggession(String input) async {
  String kPaces_Api_key="AIzaSyCl5NA3fc0r4ftV7Hp92BChKg0SvvOj3Rk";
  String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String request = '$baseURL?input=$input&key=$kPaces_Api_key&sessiontoken=$_sessionToken';

  var response= await http.get(Uri.parse(request));

  print(response.body.toString());
  if(response.statusCode==200){
  setState(() {
    placesList=jsonDecode(response.body.toString()) ["predictions"];
  });
  }else{
    throw Exception("Failed to load data");
  }




  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prue/providers/location/location_gps.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class RouteRestaurant extends StatefulWidget {
    String linkRuta;
   RouteRestaurant({Key? key, required this.linkRuta,}) : super(key: key);

  @override
  State<RouteRestaurant> createState() => _RouteRestaurantState();
  
}

class _RouteRestaurantState extends State<RouteRestaurant> {
 late String linkRuta;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
      
    }
    determinePosition();
   linkRuta =  getLink(widget.linkRuta);
  }
  @override
  Widget build(BuildContext context) {
   
return  WebView(

       
        initialUrl: linkRuta ,
        javascriptMode: JavascriptMode.unrestricted,

    );
  }
  String getLink(String link){
    return link;

}
}




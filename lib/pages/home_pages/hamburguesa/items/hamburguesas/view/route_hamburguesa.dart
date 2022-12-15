import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prue/providers/location/location_gps.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class RouteHamburguesa extends StatefulWidget {
    String linkRuta;
   RouteHamburguesa({Key? key, required this.linkRuta,}) : super(key: key);

  @override
  State<RouteHamburguesa> createState() => _RouteHamburguesaState();
  
}

class _RouteHamburguesaState extends State<RouteHamburguesa> {
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




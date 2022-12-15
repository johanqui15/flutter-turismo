import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prue/providers/location/location_gps.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RouteService extends StatefulWidget {
  String link;
  RouteService({
    Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<RouteService> createState() => _RouteServiceState();
}

class _RouteServiceState extends State<RouteService> {
  late String link;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    determinePosition();
    link = getLink(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: link,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  String getLink(String link) {
    return link;
  }
}

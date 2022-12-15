import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ConnectionWeather{






    Future<double> getWeather() async{

           double weather ;

try {
  
            Uri uri = Uri.parse('http://api.weatherunlocked.com/api/current/51.50,-0.12?app_id=a2190a0f&app_key=b694e074ee4176c686174558cbd7ea43');
            final response = await http.get(uri);

            if (response.statusCode == 200) {
              
              final body = utf8.decode(response.bodyBytes);
              final json = jsonDecode(body);

             return weather = json['temp_c'];


            }
} catch (e) {
  print(e);
}

return weather = 0;

    }




}
